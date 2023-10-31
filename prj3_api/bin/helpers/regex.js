"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activation_key = exports.email = exports.password = void 0;
exports.password = /^.+$/;
exports.email = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
exports.activation_key = /^[a-fA-F0-9]{32}$/i;
