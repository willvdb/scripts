import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { Permission } from 'src/models/permission';

@Injectable()
export class PermissionGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {

    const requiredPermissions = this.reflector.get<Permission[]>('required-permissions', context.getHandler());
    
    console.log(requiredPermissions);

    if (!requiredPermissions) {
      return true;
    }
    

    return true;
  }
}
