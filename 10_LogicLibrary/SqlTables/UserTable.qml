pragma Singleton

import QtQuick 2.0

QtObject {
    //  SQLite arguments
    readonly property string createUserTable:'CREATE TABLE IF NOT EXISTS user_accounts (email text,name text,id text,pass text,token text)'


    //  Read arguments
    readonly property string userCount: 'SELECT COUNT(*) AS sqlCounter FROM user_accounts'
    readonly property string selectAll:'SELECT * FROM user_accounts'

    //  Write arguments
    readonly property string setUserAllColumns:'INSERT INTO user_accounts VALUES(?,?,?,?,?)'
    readonly property string recordUser:'UPDATE user_accounts SET email=?,name=?,id=?,pass=?,token=? WHERE ROWID=1'
}

