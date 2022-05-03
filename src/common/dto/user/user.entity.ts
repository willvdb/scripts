
import { Role } from '@prisma/client'


export class User {
  id: number;
  name: string;
  email: string;
  username: string;
  roles: Role[];
}
