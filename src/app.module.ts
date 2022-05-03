import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './users/users.module';
import { PrismaModule } from './prisma/prisma.module';
import { RolePermissionModule } from './role-permission/role-permission.module';

@Module({
  imports: [AuthModule, UserModule, PrismaModule, RolePermissionModule],
  providers: []
})
export class AppModule {}
