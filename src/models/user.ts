import { Role } from "./role";

export class User {
    constructor(){}
    
    id: number;
    name: string;
    nickname: string;
    roles: Role[];
}
