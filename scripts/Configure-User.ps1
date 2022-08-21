# Set user password
net user ${user.name} ${user.password} 
wmic useraccount where "name='${user.name}'" set PasswordExpires=FALSE