import { Body, Controller, Get, Header, Headers, Post, UseGuards } from '@nestjs/common';
import { Permission } from '../models/permission';
import { PermissionGuard } from '../permission/permission.guard';
import { RequiredPermissions } from '../permission/required-permissions.decorator';
import { UserService } from './user.service';

@Controller('user')
@UseGuards(PermissionGuard)
export class UserController {

    constructor(private userService: UserService) {}

    @Post('test')
    @RequiredPermissions(Permission.company_edit, Permission.company_view)
    async test(@Body() body, @Headers() headers) {
        return this.userService.test();

    }
}
