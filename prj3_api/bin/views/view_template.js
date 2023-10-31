"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.res200_loggedin = exports.res200_accountactivated = exports.res201_accountcreated = exports.res200_duplicateemail = exports.res401_notactive = exports.res401_wronguserpass = exports.res500 = exports.res404_nokey = exports.res404_noroute = exports.res422 = void 0;
const res422 = (res) => {
    res.status(422).json({
        code: '422 - Unprocessable Entity',
        message: 'Thiếu hay sai tham số rồi. Request lại đi.'
    });
};
exports.res422 = res422;
const res404_noroute = (res) => {
    res.status(404).json({
        code: '404 - Not Found',
        message: 'Lạc đường rồi. Xem lại url của request đi.'
    });
};
exports.res404_noroute = res404_noroute;
const res404_nokey = (res) => {
    res.status(404).json({
        code: '404 - Not Found',
        message: 'Đường dẫn kích hoạt hết hạn hoặc không hợp lệ.'
    });
};
exports.res404_nokey = res404_nokey;
const res500 = (res) => {
    res.status(500).json({
        code: '500 - Internal Server Error',
        message: 'Có lỗi xảy ra, hãy thử lại sau.'
    });
};
exports.res500 = res500;
const res401_wronguserpass = (res) => {
    res.status(401).json({
        code: '401 - Unauthorized',
        message: 'Tài khoản hoặc mật khẩu không đúng, hãy thử lại.'
    });
};
exports.res401_wronguserpass = res401_wronguserpass;
const res401_notactive = (res) => {
    res.status(401).json({
        code: '401 - Unauthorized',
        message: 'Tài khoản chưa được kích hoạt. Chúng tôi đã gửi đường dẫn kích hoạt tới email của bạn. Hãy kích hoạt tài khoản và đăng nhập lại.'
    });
};
exports.res401_notactive = res401_notactive;
const res200_duplicateemail = (res) => {
    res.status(200).json({
        code: "200 - OK",
        message: "Email này đã được đăng ký rồi."
    });
};
exports.res200_duplicateemail = res200_duplicateemail;
const res201_accountcreated = (res) => {
    res.status(201).json({
        code: '201 - Created',
        message: 'Đăng ký thành công. Chúng tôi đã gửi đường dẫn kích hoạt tới email của bạn. Hãy kích hoạt tài khoản và đăng nhập.'
    });
};
exports.res201_accountcreated = res201_accountcreated;
const res200_accountactivated = (res) => {
    res.status(200).json({
        code: '200 - OK',
        message: 'Tài khoản đã được kích hoạt thành công.'
    });
};
exports.res200_accountactivated = res200_accountactivated;
const res200_loggedin = (res, token, expireAt) => {
    res.status(200).json({
        code: "200 - OK",
        message: "Đăng nhập thành công.",
        data: {
            token: token,
            expire_at: expireAt
        }
    });
};
exports.res200_loggedin = res200_loggedin;
