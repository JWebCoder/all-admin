import express from 'express'

export class HttpException extends Error {
  public status: number;
  public message: string;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
    this.message = message;
  }
}

export interface IUser {
  [key: string]: any,
  roles: Array<{
    id: number,
    name: string,
  }>,
}

export interface IFunfunzResponse extends express.Response {
  data?: any
}

export interface IFunfunzRequest extends express.Request {
  user?: IUser;
}