import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { PermissionService } from './permission/permission.service';
import { ModelsModule } from './models/models.module';

@Module({
  imports: [AuthModule, UserModule, ModelsModule],
  providers: [PermissionService]
})
export class AppModule {}
