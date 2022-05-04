
import {Role,Permission} from '@prisma/client'
import {ApiProperty} from '@nestjs/swagger'




export class CreateRolePermissionDto {
  @ApiProperty({ enum: Role})
role: Role;
@ApiProperty({ enum: Permission})
permission: Permission;
}
