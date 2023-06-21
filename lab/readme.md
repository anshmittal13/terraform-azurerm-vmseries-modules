
**==================For Panorama==============================**
If we want Panorama than we can just run Panorama terraform template.
And if we need Firewall that can be run after the Panorama comes.

After the Panorama comes up.

1.License the Panorama by below command:

set serial-number <>

2.Generate auth-key for bootstrapping:
request bootstrap vm-auth-key generate lifetime <1-8760>


3.Upload the config under lab folder on Panorama.


**=========For VM-Series====================================================****
Before running the terraform template for firewall.
Update below field in  terraform.tvars it will help firewall connect to Panorama automatically.

 vm-auth-key           = "<>"  (this is generated in step 2nd of Panorama)            
 authcodes          = "<>"      (auth-code to license firewall)



**==================Username and Password====================================**

Username:panadmin
Password:admin123!
