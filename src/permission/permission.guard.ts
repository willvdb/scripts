import { CanActivate, ExecutionContext, ForbiddenException, Injectable, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { Permission } from 'src/models/permission';
import { Role } from 'src/models/role';
import { User } from '../models/user';

@Injectable()
export class PermissionGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) { }

  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {

    const requiredPermissions = this.reflector.get<Permission[]>('required-permissions', context.getHandler());
    if (!requiredPermissions) {
      return true;
    } else {
      const request = context.switchToHttp().getRequest();
      //simulate the user from headers for now
      const user: User = JSON.parse(request.headers['user']);

      let hasPermission = this.roleHasPermission(user.roles, requiredPermissions);

      if (!hasPermission) {
        throw new ForbiddenException(null, "You do not have sufficient permissions to access this resource")
      }

      return hasPermission;
    }
  }


  private roleHasPermission(roles: Role[], requiredPermissions: Permission[]): boolean {
    // at least one role includes every required permission
    return roles.some(role =>
      requiredPermissions.every(requiredPermission =>
        role.permissions.includes(requiredPermission)));
  }
}
