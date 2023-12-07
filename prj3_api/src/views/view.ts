import express = require("express");

export const res422_wrongparam = (res: express.Response, message = undefined) => {
    res.status(422).json({
        code: '422 - Unprocessable Entity',
        message: message || 'Thiếu hay sai tham số rồi. Request lại đi.'
    });
};

export const res422_wrongfile = (res: express.Response) => {
    res.status(422).json({
        code: '422 - Unprocessable Entity',
        message: 'File không hỗ trợ hoặc không có file.'
    });
};

export const res404_noroute = (res: express.Response) => {
    res.status(404).json({
        code: '404 - Not Found',
        message: 'Lạc đường rồi. Xem lại url của request đi.'
    });
};

export const res404_nokey = (res: express.Response) => {
    res.status(404).json({
        code: '404 - Not Found',
        message: 'Đường dẫn kích hoạt hết hạn hoặc không hợp lệ.'
    });
};

export const res500 = (res: express.Response) => {
    res.status(500).json({
        code: '500 - Internal Server Error',
        message: 'Có lỗi xảy ra, hãy thử lại sau.'
    });
};

export const res401_wronguserpass = (res: express.Response) => {
    res.status(401).json({
        code: '401 - Unauthorized',
        message: 'Tài khoản hoặc mật khẩu không đúng, hãy thử lại.'
    });
};

export const res401_notactive = (res: express.Response) => {
    res.status(401).json({
        code: '401 - Unauthorized',
        message: 'Tài khoản chưa được kích hoạt. Chúng tôi đã gửi đường dẫn kích hoạt tới email của bạn. Hãy kích hoạt tài khoản và đăng nhập lại.'
    });
};

export const res401_wrongtoken = (res: express.Response) => {
    res.status(401).json({
        code: '401 - Unauthorized',
        message: 'Token không hợp lệ.'
    });
};

export const res403 = (res: express.Response) => {
    res.status(403).json({
        code: '403 - Forbidden',
        message: 'Bạn không đủ quyền để thực hiện hành động này.'
    });
};

export const res200_duplicateemail = (res: express.Response) => {
    res.status(200).json({
        code: "200 - OK",
        message: "Email này đã được đăng ký rồi."
    });
}

export const res201_accountcreated = (res: express.Response) => {
    res.status(201).json({
        code: '201 - Created',
        message: 'Đăng ký thành công. Chúng tôi đã gửi đường dẫn kích hoạt tới email của bạn. Hãy kích hoạt tài khoản và đăng nhập.'
    });
}

export const res200_accountactivated = (res: express.Response) => {
    res.status(200).json({
        code: '200 - OK',
        message: 'Tài khoản đã được kích hoạt thành công.'
    });
}

export const res200_fileuploaded = (res: express.Response) => {
    res.status(200).json({
        code: '200 - OK',
        message: 'File được tải lên thành công.'
    });
}