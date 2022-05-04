
import { Prisma, Role } from '@prisma/client'


export class User {
  id: number;
  createdAt: Date;
  name: string;
  email: string;
  username: string;
  roles: Role[];
  preferences: Prisma.JsonValue;
}
