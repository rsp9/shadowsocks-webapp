module github.com/shadowsocks/v2ray-plugin

require (
	github.com/golang/protobuf v1.4.2
	v2ray.com/core v0.0.0-20200918074231-20926be898fe
)

replace v2ray.com/core => github.com/v2ray/v2ray-core v0.0.0-20200918074231-20926be898fe

go 1.13
