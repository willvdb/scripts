import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { Permission, User } from '@prisma/client';
import { PermissionGuard } from '../permission/permission.guard';
import { RequiredPermissions } from '../permission/required-permissions.decorator';
import { UserService } from './user.service';

@Controller('user')
@UseGuards(PermissionGuard)
export class UserController {

    constructor(private userService: UserService) { }

    @Post('test')
    @RequiredPermissions(Permission.COMPANY_UPDATE, Permission.COMPANY_READ)
    async test() {
        return null;

    }

    @Post()
    // @RequiredPermissions(Permission.USER_CREATE)
    async createuser(@Body() body: User): Promise<User> {

        console.log(body);
        const {name, email, nickname} = body;

        return this.userService.createUser({
            name,
            email,
            nickname
        });
    }
}
