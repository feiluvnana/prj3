import { Student } from "../models/student.model";
import AuthUtils from "../utils/util";
import CustomError from "../values/error";

export default class StudentService {
    static async verifyToken(token: string): Promise<boolean> {
        return Student.findOne({
            "token.value": token,
            "token.expiredAt": {
                "$gt": Date.now()
            }
        })
            .then(student => student !== null)
            .catch(err => {
                throw new CustomError(500, "Internal Error.")
            });
    }

    static async login(email: string, password: string) {
        var student = await Student.findOne({
            "email": email,
            "password": AuthUtils.hashPassword(password)
        }, {
            "token": 1,
        }).catch(err => {
            throw new CustomError(500, "Internal Error");
        });
        if (student === null) throw new CustomError(403, "Invalid Credentials");
        student.token = AuthUtils.generateToken(email);
        await student.save().catch((err) => {
            throw new CustomError(500, "Internal Error");
        });
        return student;
    }

    static async isRegistered(email: string, password: string): Promise<boolean> {
        return Student.findOne({
            "email": email,
        })
            .then((student) => student != null)
            .catch(err => {
                throw new CustomError(500, "Internal Error");
            });
    }

    static async getStudent(token: string): Promise<any> {
        return Student.findOne({
            "token.value": token,
        })
            .then((student) => student)
            .catch(err => {
                throw new CustomError(500, "Internal Error");
            });
    }

    static async register(email: string, password: string): Promise<void> {
        let student = new Student({
            "email": email,
            "password": AuthUtils.hashPassword(password)
        });

        await student.save().catch(err => {
            throw new CustomError(500, "Internal Error")
        });
    }
}