import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { ApiCreatedResponse, ApiForbiddenResponse, ApiNotFoundResponse, ApiOkResponse, ApiParam, ApiProperty, ApiQuery, ApiTags, ApiUnauthorizedResponse } from '@nestjs/swagger';
import { PermissionGuard } from '../permission/permission.guard';
import { User } from '../common/dto/user/user.entity';
import { UsersService } from './users.service';
import { CreateUserDto } from '../common/dto/user/create-user.dto';
import { RequiredPermissions } from '../permission/required-permissions.decorator';
import { Permission } from '@prisma/client';

@Controller('users')
@UseGuards(PermissionGuard)
export class UsersController {

    constructor(private userService: UsersService) { }

    @Get(":username")
    @RequiredPermissions(Permission.USER_READ)
    @ApiTags("users")
    @ApiParam({
        name: "username",
        required: true,
        description: "the username for the user you'd like returned",
        schema: {
            type: "string"
        }
    })
    @ApiOkResponse({description: "Returns the user with the given username"})
    @ApiNotFoundResponse({description: "Could not find a user with the given username"})
    async getUser( @Param('username') username): Promise<User> {
        return this.userService.getUser({
            username,
        })
    }

    @Post()
    @ApiTags("users")
    @ApiCreatedResponse({description: "User was successfully created. Will return the created user."})
    @ApiForbiddenResponse({description: "You do not have permission to perform this operation"})
    // @RequiredPermissions(Permission.USER_CREATE)
    async createuser(@Body() body: CreateUserDto): Promise<User> {

        console.log(body);
        const {name, email, username} = body;

        return this.userService.createUser({
            name,
            email,
            username
        });
    }
}
