import { Role } from "./role";

export class User {
    id: number;
    name: string;
    nickname: string;
    roles: Role[];
}
