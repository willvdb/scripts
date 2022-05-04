
import {Role,Permission} from '@prisma/client'


export class RolePermission {
  id: number ;
createdAt: Date ;
role: Role ;
permission: Permission ;
}
