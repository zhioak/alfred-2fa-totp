# 2FA TOTP Workflow for Alfred

一个支持生成TOOP密码的Alfred工作流

## ⚙️ 环境准备

### 生成OTP

将对应的TOTP二维码解析，其中`SECRET`就是TOTP对应的秘钥

```bash
otpauth://totp/zhioak?secret=SECRET&issuer=111
```

安装授权工具

```bash
brew install oath-toolkit
```

生成OTP后与TOTP APP中显示的比对，生成的一样就是没问题

```bash
oathtool --totp --base32 "SECRET"
```

### 统一管理

创建文件夹统一管理秘钥

```bash
mkdir ~/.totp && cd ~/.totp
```

写入秘钥文件

```bash
echo 'SECRET' > github-plain
```

### 秘钥加密

下载ssh加密工具

```bash
curl -O https://raw.githubusercontent.com/5im-0n/sshenc.sh/master/sshenc.sh
```

增加执行权限

```bash
chmod 555 sshenc.sh && chown root sshenc.sh
```

移动命令

```bash
sudo mv sshenc.sh /usr/local/bin/sshenc
```

对明文加密

```bash
sshenc -p ~/.ssh/id_rsa.pub < github-plain > github.key
```

解密

```bash
sshenc -s ~/.ssh/id_rsa < github.key
```

删除明文秘钥

```bash
rm github-plain
```

## ⚙️ 使用

![Preview](https://raw.githubusercontent.com/zhioak/pics/master/picgo/2025-03%2FiShot_2025-03-19_17.31.33-1ca2dd.png)

## 特别鸣谢

- [一日一技 | 用 LaunchBar 等启动器快速输入双重认证密码 - 少数派 (sspai.com)](https://sspai.com/post/64624)
- [Over 5000+ free icons for macOS Monterey, Big Sur & iOS - massive app icon pack (macosicons.com)](https://macosicons.com/#/u/pptxman)