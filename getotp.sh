#!/bin/bash  

export PATH="/usr/bin:$PATH"

output=''
  
# 遍历 ~/.totp 目录下所有以 .key 结尾的文件  
for key_file in ~/.totp/*.key; do  

    if [[ -f "$key_file" ]]; then  

        # 解密totp秘钥
        totp_secret=$(sshenc -s ~/.ssh/id_rsa < "$key_file")  
          
        # 获取一次性密码 
        otp=$(oathtool --totp --base32 "$totp_secret")  
          
		if [[ -z "$output" ]]; then
			output='{"rerun": 1, "items":['
		else
			output+=','
			if [[ "$3" == "--newline" ]]; then
				output+="\n"
			fi
		fi

		# 获取文件名
		filename=$(basename "$key_file")
		
		item="{\"type\":\"default\", \"icon\": {\"path\": \"icon.png\"}, \"arg\": \"$otp\", \"subtitle\": \"${filename}\", \"title\": \"$otp\"}"
    	output+=$item
    fi  
done
  

if [[ -z "$output" ]]; then
	output+='{
		"rerun": 1,
		"items": [
			{
				"type": "default", 
				"valid": "false", 
				"icon": {"path": "icon.png"}, 
				"arg": "", 
				"subtitle": "The *.key file was not found in the .totp", 
				"title": "No TOTP key found"
			}
		]
	}'
else
	output+=']}'
fi

echo $output
 