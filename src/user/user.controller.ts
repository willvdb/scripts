import { Controller, Get, UseGuards } from '@nestjs/common';
import { Permission } from 'src/models/permission';
import { PermissionGuard } from 'src/permission/permission.guard';
import { RequiredPermissions } from 'src/permission/required-permissions.decorator';
import { UserService } from './user.service';

@Controller('user')
@UseGuards(PermissionGuard)
export class UserController {

    constructor(private userService: UserService) {}

    @Get('test')
    @RequiredPermissions(Permission.user_view, Permission.user_edit)
    async test() {
        return this.userService.test();

    }
}
