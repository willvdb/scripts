import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { ModelsModule } from './models/models.module';

@Module({
  imports: [AuthModule, UserModule, ModelsModule],
  providers: []
})
export class AppModule {}
