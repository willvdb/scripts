import { Controller, Post, UseGuards } from '@nestjs/common';
import { Permission } from '@prisma/client';
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

    private helloWorld(twenty: number) {
        return twenty + 5;
    }
}
