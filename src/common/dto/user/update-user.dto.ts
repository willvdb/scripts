
import { Role } from '@prisma/client'
import { ApiProperty } from '@nestjs/swagger'




export class UpdateUserDto {
  name?: string;
  email?: string;
  username?: string;
  @ApiProperty({ enum: Role })
  roles?: Role[];
}
