import { SetMetadata } from '@nestjs/common';
import { Permission } from 'src/models/permission';

export const RequiredPermissions = (...args: Permission[]) => SetMetadata('required-permissions', args);
