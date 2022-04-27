import { Injectable } from '@nestjs/common';
import { User } from 'src/models/user';

@Injectable()
export class PermissionService {

    hasPermission(user: User, ): boolean {
        return true;
    }
}
