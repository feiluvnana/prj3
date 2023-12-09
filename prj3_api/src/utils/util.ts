import crypto = require('crypto');

export default class AuthUtils {
    static generateToken(email: string) : {value: string, expiredAt: number} {
        var now = Date.now();
        return {
            value: crypto.createHash('sha1').update(email + now.toString()).digest("hex"),
            expiredAt: now + 1000 * 3600 * 24
        }
    }

    static hashPassword(password: string) : string {
        return crypto.createHash('sha256').update(password).digest("hex");
    }
}