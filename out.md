Subject: Flying club member deletion at VRed files collection by SFTP from sftp1.fly.virgin.com

Hi Sonia,

We are currently setting up a file transfer mechanism to receive a list of
flying club numbers from you to delete on our side (I know that you've spoken
to Anna Lay about this before). To set up the process, we want to use the
existing pattern of collecting the files from your SFTP server, `sftp1.fly.virgin.com`.

We already collect files from your server for two other flows:

- GPA files: login VRED_GPA_TEST (test) and VRED_GPA_PROD (live).
- Financial partners: login VRED_FP_TEST (test) and VRED_FP_PROD (live). We read these folders:
  /AXZA/TEST/ and /AXZA/LIVE/
  /VCCU/TEST/VOUCHER-ACCRUAL/ and /VCCU/LIVE/VOUCHER-ACCRUAL/

We want to use the same method for the flying club numbers. We will connect from the
same IP addresses, so no firewall change is necessary.

If you could please answer these three questions then we can set things up on our side:

1. Which login do we use?
   a) An existing login (VRED_GPA or VRED_FP). Then you only add the new GDPR
   (or flying club numbers) folders.
   b) A new login, for example VRED_GDPR_TEST and VRED_GDPR_PROD. If you choose
   this, register our existing public SSH key on the new login.

2. What are the folder paths for the two file types (card number files and profile files)? For example:
   Test: /GDPR/TEST/FLYING_CARD_NUMBER/
   Live: /GDPR/LIVE/FLYING_CARD_NUMBER/

The file format must adhere to this csv format. Each file is a CSV file
that has two headers:

```csv
identifier,profile_id
1234567890,<optional>
1234567891,<optional>
1234567892,<optional>
1234567893,<optional>
```

In this case we want the flying club numbers to be in the first column please.

Thank you in advance,

Mike Park
