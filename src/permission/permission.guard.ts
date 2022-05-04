import { CanActivate, ExecutionContext, ForbiddenException, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Permission, Role, User } from '@prisma/client';
import { Observable } from 'rxjs';

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
      const username: string = request.headers['username']; //simulate the user from headers for now
      // const hasPermission = this.roleHasPermission(user.roles, requiredPermissions);

      if (username !== 'jim') {
        throw new ForbiddenException(null, "You do not have sufficient permissions to access this resource")
      }

      return true;//hasPermission;
    }
  }


  private roleHasPermission(roles: Role[], requiredPermissions: Permission[]): boolean {
    const rolePermissions: Permission[] = roles.flatMap(role => this.getRolePermissions(role));
    // at least one role includes every required permission
    return roles.some(role =>
      requiredPermissions.every(requiredPermission =>
        rolePermissions.includes(requiredPermission)));
  }

  private getRolePermissions(role: Role) {
    return [];
  }
}
