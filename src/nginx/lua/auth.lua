-- remote user名を取得
local remote_user = ngx.var.remote_user
if remote_user ~= "test001" then
    -- test001ユーザーでなければ401
    ngx.header.content_type = "text/plain"
    ngx.log(ngx.STDERR, remote_user.." にはアクセス権がありません")
    ngx.status = ngx.HTTP_UNAUTHORIZED
    return ngx.exit(ngx.status)
end