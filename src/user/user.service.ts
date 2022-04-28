import { Injectable } from '@nestjs/common';
import { Permission } from 'src/models/permission';
import { Role } from 'src/models/role';
import { User } from 'src/models/user';

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
