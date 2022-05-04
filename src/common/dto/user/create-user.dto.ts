
import { ApiProperty } from '@nestjs/swagger';
import { Role } from '@prisma/client';
import { IsEmail, IsNotEmpty } from 'class-validator';




export class CreateUserDto {
  @ApiProperty({ example: "Bob Johnson" })
  @IsNotEmpty()
  name: string;

  @ApiProperty({ format: "email" })
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @ApiProperty({ example: "bob" })
  @IsNotEmpty()
  username: string;

  @ApiProperty({ type: "array", items: { type: "string", enum: Object.keys(Role) } })
  roles?: Role[];
}
