import { Controller, Get } from '@nestjs/common';
import { PermissionService } from 'src/permission/permission.service';
import { UserService } from './user.service';

@Controller('user')
export class UserController {

    constructor(private userService: UserService) {}

    @Get('test')
    async test() {
        return this.userService.test();

    }
}
