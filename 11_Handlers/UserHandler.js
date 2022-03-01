function createUserTable() {
    myLog('\ncreateUserTable(){')
    let success=errorHandling(()=>{
                                  openDatabase().transaction(function (tx) {
                                      tx.executeSql(__USER_TABLE.createUserTable)
                                      let sqlCommand=tx.executeSql(__USER_TABLE.userCount)
                                      let lineCount =sqlCommand.rows.item(0).sqlCounter
                                      if(lineCount===0)
                                          tx.executeSql(__USER_TABLE.setUserAllColumns,[emptyField,emptyField,emptyField,emptyField,emptyField])
                                  })},'createUserTable()[sql/UserHandler.js]')
    if (success) myLog('\tUser table created or already exists\n}')
    else myLog('\tError creating user table\n}')
}

function checkCurrentUser(){
    myLog('\ncheckCurrentUser(){')
    var exit=false
    let success=errorHandling(()=>{
                                  openDatabase().transaction(function(tx){
                                      var sqlCommand=tx.executeSql(__USER_TABLE.selectAll)
                                      if(sqlCommand.rows.length>0 && sqlCommand.rows.item(0).id!==emptyField){
                                          userObj.setObj(sqlCommand.rows.item(0).name,
                                                         sqlCommand.rows.item(0).email,
                                                        sqlCommand.rows.item(0).token,
                                                         sqlCommand.rows.item(0).pass,
                                                         sqlCommand.rows.item(0).id
                                                         )
                                          myLog('\tuser found! user uid > '+sqlCommand.rows.item(0).uid)
                                          myLog(JSON.stringify(userObj))
                                          exit=true
                                      }else myLog('\tno user found')
                                  })},'checkCurrentUser()[UserHandler.js]')

    if (!success)myLog('\tError checking user')
    myLog('\treturned value: '+exit)
    myLog('\tend of ncheckCurrentUser()\n}')
    return exit
}

function recordCurrentUser(user){
    myLog('\nrecordCurrentUser( {'+user.email,user.name,user.id,user.pass,user.token+'}){')
    let success=errorHandling(()=>{
                                  openDatabase().transaction(function(tx){
                                      tx.executeSql(__USER_TABLE.recordUser,[user.email,user.name,user.id,user.pass,user.token])
                                  })
                              },'recordCurrentUser()[UserHandler.js]')
    if(success)myLog('User recorded\n}<recordCurrentUser>\n')
    else myLog('User not recorded\n}<recordCurrentUser>\n')
}

function logUserOut(){
    myLog('\nlogout current user')
    let success=errorHandling(()=>{
                                  openDatabase().transaction(function(tx){
                                      tx.executeSql(__USER_TABLE.recordUser,[emptyField,emptyField,emptyField,emptyField,emptyField])
                                      //                                      stackView.push(loginForm)
                                  })
                              },'logUserOut()[UserHandler.js]')
    if(success)myLog('User loged out succesfully\n')
    else myLog('Error loging user out\n')
}
