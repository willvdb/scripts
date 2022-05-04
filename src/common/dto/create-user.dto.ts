
import { ApiParam, ApiProperty } from '@nestjs/swagger';
import { Role } from '@prisma/client';




export class CreateUserDto {
  name: string;
  email: string;
  username: string;
  roles: Role[];
}
