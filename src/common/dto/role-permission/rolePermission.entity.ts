
import {Role,Permission} from '@prisma/client'


export class RolePermission {
  id: number ;
role: Role ;
permission: Permission ;
}
