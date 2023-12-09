export default class InternalError {
    status: number;
    message: string;

    constructor(status:number, message: string) {
        this.message = message;
        this.status = status;
    }
}