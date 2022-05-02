import { Injectable } from '@nestjs/common';
import { Permission } from '../models/permission';
import { Role } from '../models/role';
import { User } from '../models/user';

@Injectable()
export class UserService {

    test(): string {
        let user = new User();
        user.id = 0;
        user.name = "Robert";
        user.nickname = "Bob";
        let role = new Role();
        role.id = 0;
        role.name = "analyst";
        role.permissions = [
            Permission.company_view,
            Permission.company_edit
        ];
        user.roles = [
            role
        ]
        return JSON.stringify(user);
    }
}
