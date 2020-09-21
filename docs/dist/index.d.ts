import "xterm/css/xterm.css";
import EventEmitter from "wolfy87-eventemitter";
declare class PWD extends EventEmitter {
    instances: {};
    instanceBuffer: {};
    sessionId: any;
    opts: any;
    socket: any;
    terms: any[];
    setOpts(opts: any): void;
    login(cb: any): void;
    createSession(cb: any): void;
    newSession(terms: any, opts: any, callback: any): void;
    closeSession(callback: any): void;
    getUserInfo(callback: any): void;
    init(sessionId: any, opts: any, callback: any): void;
    resize(): void;
    createInstance: (opts: any, callback: any) => void;
    upload(name: any, opts: any, callback?: (any: any) => void): void;
    setup(data: any, callback: any): void;
    exec(name: any, data: any, callback: any): void;
    getInstances(): any[];
    createTerminal(term: any, name: any): any;
    terminal(term: any, callback?: any): void;
}
export default PWD;
