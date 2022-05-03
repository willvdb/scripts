import { SetMetadata } from '@nestjs/common';
import { Permission } from '@prisma/client';

export const RequiredPermissions = (...args: Permission[]) => SetMetadata('required-permissions', args);
