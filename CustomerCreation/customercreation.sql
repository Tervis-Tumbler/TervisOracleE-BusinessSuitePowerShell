DECLARE
g_created_by_module  VARCHAR2(100) := 'TCA_V1_API';--'TCA_FORM_WRAPPER';
p_account_name    VARCHAR2(100):='SRG00805_08';
p_account_number  VARCHAR2(100):= NULL;--'SRG0710_9';
p_org_name        VARCHAR2(100):='SRG0805_08 Party Name';
p_b_country     VARCHAR2(10):='US';
p_b_address1    VARCHAR2(100):='B_Address1';
p_b_address2    VARCHAR2(100):='B_Address2';
p_b_address3    VARCHAR2(100):='B_Address3';
p_b_city        VARCHAR2(20):='San Mateo';
p_b_postal_code VARCHAR2(10):= '94401';
p_b_state       VARCHAR2(10):= 'CA';
p_b_province   VARCHAR2(20);
p_s_country     VARCHAR2(10):='US';
p_s_address1    VARCHAR2(100):='S_Address1';
p_s_address2    VARCHAR2(100):='S_Address2';
p_s_address3    VARCHAR2(100):='S_Address3';
p_s_city        VARCHAR2(20):='San Mateo';
p_s_postal_code VARCHAR2(10):= '94401';
p_s_state       VARCHAR2(10):= 'CA';
p_s_province   VARCHAR2(20);
p_org_id       NUMBER:=82;
p_sm_bill_ship_use  VARCHAR2(1):='N';
p_bill_ship_site_same     VARCHAR2(1) :='N';
p_currency_code   VARCHAR2(10):='USD';
p_credit_limit   NUMBER :=56000;
p_pre_cbname_adjunct  VARCHAR2(10):='MR.';
p_cbfirst_name       VARCHAR2(100):= 'Mark';
p_cblast_name       VARCHAR2(100):= 'Zukerburg';
p_bphone_line_type   VARCHAR2(10):='GEN';
p_bphone_area_code   VARCHAR2(10);--:='408';
p_bphone_number      VARCHAR2(20):='308-888-999';
--p_phone_extension   VARCHAR2(10):='1';
p_pre_csname_adjunct  VARCHAR2(10):='MR.';
p_csfirst_name       VARCHAR2(100):= 'Larry';
p_cslast_name       VARCHAR2(100):= 'Page';
p_sphone_line_type   VARCHAR2(10):='GEN';
p_sphone_area_code   VARCHAR2(10);--:='408';
p_sphone_number      VARCHAR2(20):='308-777-4444';
p_semail_address          VARCHAR2(100):='test@fb.com';
--p_bemail_address          VARCHAR2(100):='test@fb.com';
p_contact_level     VARCHAR2(20):='SITE';--'ACCOUNT';
p_customer_type       VARCHAR2(100);
p_cust_category_code    VARCHAR2(100);
p_customer_class_code   VARCHAR2(100);
p_ship_via              VARCHAR2(100);
p_attribute1            VARCHAR2(100);
p_attribute2            VARCHAR2(100);
p_attribute3            VARCHAR2(100);
p_attribute4            VARCHAR2(100);
p_attribute5            VARCHAR2(100);
p_attribute6            VARCHAR2(100);
p_attribute9            VARCHAR2(100);
p_profile_class_id      NUMBER;
--p_fax_area_code         VARCHAR2(10):='408'; 
--p_fax_num               VARCHAR2(12):='234-6789';
--p_url                   VARCHAR2(100):='www.bizinsightinc.com';
/********************/
p_price_list_name       VARCHAR2(100):= 'AMERICROWN';
p_order_type            VARCHAR2(100):= 'ITC Sales Order';
p_customer_class        VARCHAR2(100):= 'SPORTS';
p_salesrep              VARCHAR2(100):= 'EDWARDS, ALISSA';
p_ship_set          VARCHAR2(100):='true';
p_sales_channel     VARCHAR2(20):='INDIRECT';--'DIRECT';
p_ship_via_code     VARCHAR2(20):='000001_ABF_L_LTL';
p_freight_terms     VARCHAR2(20):='COLLECT';
p_fob_code          VARCHAR2(10):='FACTORY';
p_site_customer_class        VARCHAR2(100):= 'SPORTS';
p_site_ship_set          VARCHAR2(100):='true';
p_site_sales_channel     VARCHAR2(20):='INDIRECT';--'ITC.GOLD';--'DIRECT';
p_site_ship_via_code     VARCHAR2(20):='000001_ABF_L_LTL';
p_site_freight_terms     VARCHAR2(20):='COLLECT';
p_site_fob_code          VARCHAR2(10):='FACTORY';--'BUY';
p_blind_shipments    VARCHAR2(3):='Yes';
p_site_blind_shipments    VARCHAR2(3):='Yes';
/*************/

/*
p_price_list_name       VARCHAR2(100);
p_order_type            VARCHAR2(100);
p_customer_class        VARCHAR2(100);
p_salesrep              VARCHAR2(100);
p_ship_set              VARCHAR2(100);
p_sales_channel         VARCHAR2(20);
p_ship_via_code         VARCHAR2(20);
p_freight_terms         VARCHAR2(20);
p_fob_code              VARCHAR2(10);
p_site_customer_class   VARCHAR2(100);
p_site_ship_set         VARCHAR2(100);
p_site_sales_channel    VARCHAR2(20);
p_site_ship_via_code    VARCHAR2(20);
p_site_freight_terms    VARCHAR2(20);
p_site_fob_code         VARCHAR2(10);
p_blind_shipments       VARCHAR2(1);
p_site_blind_shipments  VARCHAR2(1);
*/
l_step                 VARCHAR2(1000);
l_err_msg              VARCHAR2(1000);
lx_acct_status         VARCHAR2(1):='E';
lx_bloc_status         VARCHAR2(1):='E';
lx_sloc_status         VARCHAR2(1):='E';
lx_ba_site_status      VARCHAR2(1):='E';
lx_sa_site_status      VARCHAR2(1):='E'; 
lx_bsite_status        VARCHAR2(1):='E';
lx_ssite_status        VARCHAR2(1):='E';
lx_ba_site_use_status  VARCHAR2(1):='E';
lx_sa_site_use_status  VARCHAR2(1):='E';
lx_bcontact_status     VARCHAR2(1):='E'; 
lx_scontact_status     VARCHAR2(1):='E'; 
lx_brel_status         VARCHAR2(1):='E';
lx_srel_status         VARCHAR2(1):='E';
lx_brole_status        VARCHAR2(1):='E';
lx_srole_status        VARCHAR2(1):='E'; 
lx_bconpoint_status    VARCHAR2(1):='E'; 
lx_sconpoint_status    VARCHAR2(1):='E'; 
lx_sEconpoint_status    VARCHAR2(1):='E'; 
lx_bresp_status    VARCHAR2(1):='E';
lx_sresp_status    VARCHAR2(1):='E';


--lx_phone_status        VARCHAR2(1):='E'; 
lx_assi_status         VARCHAR2(1):='E';
lx_email_status        VARCHAR2(1):='E'; 
lx_fax_status          VARCHAR2(1):='E'; 
lx_url_status          VARCHAR2(1):='E'; 

lx_party_id       NUMBER;
lx_cust_acct_id   NUMBER;
lx_cust_profile_id  NUMBER;
l_bcparty_id      NUMBER;
l_scparty_id      NUMBER;
--p_brel_party_id      NUMBER;
--p_srel_party_id      NUMBER;
l_b_location_id     NUMBER;--Bill
l_s_location_id     NUMBER; --Ship
l_sparty_site_id   NUMBER; --Bill
l_bparty_site_id   NUMBER; --Ship
l_cust_acct_bsite_id   NUMBER;  --bill
l_cust_acct_ssite_id   NUMBER;  --bill
l_cust_acc_brole_id    NUMBER;
l_cust_acc_srole_id  NUMBER;
l_brel_party_id      NUMBER;
l_srel_party_id      NUMBER;
l_bcontact_point_id NUMBER;
l_scontact_point_id NUMBER;
l_sEcontact_point_id NUMBER;
--p_cparty_id           NUMBER;
--p_cust_profile_id   NUMBER;
--p_org_party_id      NUMBER;
l_object_type       VARCHAR2(20);
l_object_table      VARCHAR2(20);
l_bill_site_use_id      NUMBER;
l_ship_site_use_id      NUMBER;
l_site_use_id           NUMBER;


l_list_header_id       NUMBER;
l_order_type_id        NUMBER;
l_customer_class_code    VARCHAR2(100);
l_salesrep_id              NUMBER;
l_ship_set                 VARCHAR2(1);
l_sales_channel                VARCHAR2(100);
l_ship_via                 VARCHAR2(100);
l_freight_terms           VARCHAR2(200);
l_fob_code          VARCHAR2(100);
l_blind_shipments   VARCHAR2(5);
l_site_ship_set                 VARCHAR2(1);
l_site_sales_channel                VARCHAR2(100);
l_site_ship_via                 VARCHAR2(100);
l_site_freight_terms           VARCHAR2(200);
l_site_fob_code          VARCHAR2(100);
l_site_blind_shipments   VARCHAR2(5);
CUST_CC_ERROR     EXCEPTION;
----------------------------------------
-----------------Accounts Variables-----------------
l_cust_account_rec     HZ_CUST_ACCOUNT_V2PUB.CUST_ACCOUNT_REC_TYPE;
 l_organization_rec     HZ_PARTY_V2PUB.ORGANIZATION_REC_TYPE;
 l_customer_profile_rec HZ_CUSTOMER_PROFILE_V2PUB.CUSTOMER_PROFILE_REC_TYPE;
 l_cust_profile_rec      hz_customer_profile_v2pub.customer_profile_rec_type;
 x_cust_account_id NUMBER;
 x_party_id NUMBER;
 x_account_number   VARCHAR2(2000);
 x_party_number     VARCHAR2(2000);
 x_profile_id       NUMBER;
 x_return_status       VARCHAR2(2000);
 x_msg_count        NUMBER;
 x_msg_data         VARCHAR2(2000);
 x_cust_profile_id       NUMBER;
 l_msg_index             NUMBER;
 l_err_desc              VARCHAR2 (4000) := NULL;
 ---------------End of Accounts Variables------------------
 ---------------Location variables-------------------------
  l_location_rec HZ_LOCATION_V2PUB.LOCATION_REC_TYPE;
   x_location_id NUMBER;
 -----------------End of Location variables--------------------- 
  l_party_site_rec HZ_PARTY_SITE_V2PUB.PARTY_SITE_REC_TYPE;
  x_party_site_id NUMBER;
  x_party_site_number VARCHAR2(2000);
----------------------------------------------------------------- 
p_cust_acct_site_rec hz_cust_account_site_v2pub.cust_acct_site_rec_type;
x_cust_acct_site_id         NUMBER;
------------------------------------------------------------------
 p_cust_site_use_rec HZ_CUST_ACCOUNT_SITE_V2PUB.CUST_SITE_USE_REC_TYPE;
 p_customer_profile_rec HZ_CUSTOMER_PROFILE_V2PUB.CUSTOMER_PROFILE_REC_TYPE;
 x_site_use_id NUMBER;
--------------------------------------------------------------------- 
 p_create_person_rec HZ_PARTY_V2PUB.person_rec_type;
 x_cbparty_id NUMBER;
 x_cbparty_number VARCHAR2(2000);
 x_cbprofile_id NUMBER;
 
 x_csparty_id NUMBER;
 x_csparty_number VARCHAR2(2000);
 x_csprofile_id NUMBER;
---------------------------------------------------------------------------- 
p_org_contact_rec HZ_PARTY_CONTACT_V2PUB.ORG_CONTACT_REC_TYPE;
x_borg_contact_id NUMBER;
x_bparty_rel_id NUMBER;
x_brparty_id    NUMBER;
x_brparty_number VARCHAR2(2000);

x_sorg_contact_id NUMBER;
x_sparty_rel_id   NUMBER;
x_srparty_id      NUMBER;
x_srparty_number  VARCHAR2(2000);
----------------------------------------------------------------------------
p_cr_cust_acc_role_rec HZ_CUST_ACCOUNT_ROLE_V2PUB.cust_account_role_rec_type;
x_cust_account_brole_id NUMBER;
x_cust_account_srole_id NUMBER;
----------------------------------------------------------------------------
p_contact_point_rec HZ_CONTACT_POINT_V2PUB.CONTACT_POINT_REC_TYPE;
p_phone_rec HZ_CONTACT_POINT_V2PUB.phone_rec_type;
p_edi_rec_type HZ_CONTACT_POINT_V2PUB.edi_rec_type;
p_email_rec_type HZ_CONTACT_POINT_V2PUB.email_rec_type;
p_telex_rec_type HZ_CONTACT_POINT_V2PUB.telex_rec_type;
p_web_rec_type HZ_CONTACT_POINT_V2PUB.web_rec_type;
x_bcontact_point_id NUMBER;
x_scontact_point_id NUMBER;
x_sEcontact_point_id NUMBER;
-----------------------------------------------------------------------------
p_role_responsibility_rec HZ_CUST_ACCOUNT_ROLE_V2PUB.ROLE_RESPONSIBILITY_REC_TYPE;
x_bresponsibility_id NUMBER;
x_sresponsibility_id NUMBER;

BEGIN
l_step:='Start';

dbms_output.put_line(l_step);
l_step:= 'Calling Addiitonal Attribute Validations for Account';
dbms_output.put_line(l_step);
----------------------------------------------------
--Derive Price List Name
l_step:='Derive Price List Name';
dbms_output.put_line(l_step);
BEGIN
SELECT list_header_id
  INTO l_list_header_id
  FROM qp_list_headers_all
 WHERE name =  p_price_list_name 
   AND sysdate between NVL(start_date_active,sysdate) and NVL(end_date_active,sysdate)
   AND list_type_code ='PRL';
 dbms_output.put_line('price List ID -'|| l_list_header_id); 
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Price List details found');
    l_list_header_id:= NULL;
END;

l_step:='Derive Order Type';
dbms_output.put_line(l_step);
BEGIN
SELECT t.transaction_type_id  
  INTO l_order_type_id
  FROM oe_transaction_types_all t,oe_transaction_types_tl tl
 WHERE t.transaction_type_code  = 'ORDER' 
   AND t.transaction_type_id = tl.transaction_type_id
   AND tl.language = userenv('LANG')
   and tl.name = p_order_type;
 dbms_output.put_line('l.order_type_id -'|| l_order_type_id);
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Order Type details found');
    l_order_type_id:= NULL;
END;

l_step:='Derive Customer Class';
dbms_output.put_line(l_step);
BEGIN
SELECT lookup_code
INTO   l_customer_class_code
FROM ar_lookups
WHERE lookup_type like 'CUSTOMER CLASS'
AND (UPPER(p_customer_class) = UPPER(MEANING) or UPPER(p_customer_class) = UPPER(LOOKUP_CODE))
AND sysdate between NVL(start_date_active,sysdate) and NVL(end_date_active,sysdate);
 dbms_output.put_line('l_customer_class_code -'|| l_customer_class_code);
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Valid Customer Class details found');
    l_customer_class_code:= NULL;
END;

l_step:='Derive Sales Rep';
dbms_output.put_line(l_step);
BEGIN
SELECT ra.salesrep_id--UPPER(res.source_first_name)||' '||UPPER(res.source_last_name)--salesrep_name
  INTO l_salesrep_id
  FROM apps.jtf_rs_resource_extns_vl res, apps.ra_salesreps_all ra
 WHERE UPPER(ra.name) = UPPER(p_salesrep)
 --UPPER(res.source_first_name)||' '||UPPER(res.source_last_name) = UPPER(p_salesrep)
   AND res.resource_id = ra.resource_id;
  dbms_output.put_line('l_salesrep_id -'|| l_salesrep_id);
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('Not Valid Sales Rep');
    l_salesrep_id:= NULL;
END;


l_step:='Derive Ship Set';
dbms_output.put_line(l_step);
BEGIN

 SELECT lookup_code
   INTO l_ship_set
   FROM ar_lookups
  WHERE lookup_type = 'YES/NO'
    AND (UPPER(lookup_code) = UPPER(decode(p_ship_set,'false','N','true','Y',NULL))
    OR UPPER(meaning) = UPPER(decode(p_ship_set,'false','No','true','Yes',NULL)))
    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
    AND enabled_flag = 'Y';
    dbms_output.put_line('Ship Set -'||l_ship_set);
  dbms_output.put_line('l_ship_set -'|| l_ship_set);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Ship Set');
    l_ship_set:='N';
END ;

l_step:='Derive Blind Shipment';
dbms_output.put_line(l_step);
BEGIN

 SELECT Decode (lookup_code,'YES','Y','No','N',NULL)
   INTO l_blind_shipments
                   FROM oe_lookups
                  WHERE lookup_type = 'OM_YES_NO'
                    AND (UPPER(lookup_code) = UPPER(p_blind_shipments) OR UPPER(meaning) = UPPER(p_blind_shipments))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y';
    dbms_output.put_line('Account blind_shipment  -'||l_blind_shipments);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Value for Bline Shipment');
    l_blind_shipments:= NULL;
END ;

l_step:='Derive FOB';
dbms_output.put_line(l_step);
BEGIN
  SELECT lookup_code
    INTO l_fob_code
                   FROM ar_lookups
                  WHERE lookup_type = 'FOB'
                    AND (UPPER(lookup_code) = UPPER(p_fob_code) OR UPPER(meaning) = UPPER(p_fob_code))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y'; 
                    dbms_output.put_line(' l_fob_code >>>>  -'||l_fob_code);
                    
EXCEPTION 
 WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid fob');
    l_fob_code:=NULL;
END;

l_step:='Derive PShip Via';
dbms_output.put_line(l_step);                    
BEGIN                   
SELECT lookup_code
  INTO l_ship_via
  FROM apps.oe_ship_methods_v
 WHERE (UPPER(lookup_code) = UPPER(p_ship_via_code) OR UPPER(meaning) = UPPER(p_ship_via_code))
   AND enabled_flag = 'Y'   ;
   dbms_output.put_line(' Ship Via  -'||l_ship_via);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Ship Via ');
    l_ship_via:=NULL;
END; 

l_step:='Derive Freight Terms';
dbms_output.put_line(l_step);
BEGIN
 SELECT lookup_code
   INTO l_freight_terms
   FROM so_lookups
  WHERE lookup_type = 'FREIGHT_TERMS'
    AND (UPPER(lookup_code) = UPPER(p_freight_terms) OR UPPER(meaning) = UPPER(p_freight_terms))
    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
    AND enabled_flag = 'Y';
    dbms_output.put_line('Freight term - '||l_freight_terms);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Freight terms');
  l_freight_terms:=NULL;
END; 

l_step:='Derive Sales Channel';
dbms_output.put_line(l_step);
BEGIN
        SELECT lookup_code
                   into l_sales_channel
                   FROM so_lookups
                  WHERE lookup_type = 'SALES_CHANNEL'
                    AND (UPPER(lookup_code) = UPPER(p_sales_channel) OR UPPER(meaning) = UPPER(p_sales_channel))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y' ;
                    dbms_output.put_line('Sales channel >>>> '||l_sales_channel);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Sales Channel');
     l_sales_channel:= NULL;
END;
-----------------------------------------------------



---++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Create Customer Party and Account
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
l_step:= 'Create Customer Account and Party';
dbms_output.put_line(l_step);
BEGIN
dbms_output.put_line(p_sales_channel||'-'||p_ship_via_code||'-'||p_freight_terms||'-'||p_fob_code );
dbms_output.put_line('Create Customer Account');
l_step:= 'Populate API Variables';
dbms_output.put_line(l_step);
 l_organization_rec.organization_name := p_org_name;
 l_organization_rec.created_by_module := g_created_by_module;
 l_cust_account_rec.account_name := p_account_name;--'SRG001';
 l_cust_account_rec.created_by_module := g_created_by_module;
 l_cust_account_rec.account_number := p_account_number;
 l_cust_account_rec.customer_type       :=  p_customer_type;
 l_cust_account_rec.customer_class_code :=  p_customer_class_code;
 l_cust_account_rec.fob_point           :=  p_fob_code;
 l_cust_account_rec.freight_term        :=  p_freight_terms;
 l_cust_account_rec.sales_channel_code  :=  p_sales_channel;
 l_cust_account_rec.price_list_id       :=  l_list_header_id; --Need to derive ID from Name
-- l_cust_account_rec.order_type_id       :=  p_order_type_id;--Need to derive from Order Type name
 l_cust_account_rec.ship_via            :=  l_ship_via;
 l_cust_account_rec.SHIP_SETS_INCLUDE_LINES_FLAG := l_ship_set;
 l_cust_account_rec.attribute1          :=  p_attribute1;
 l_cust_account_rec.attribute2          :=  p_attribute2;
 l_cust_account_rec.attribute3          :=  p_attribute3;
 l_cust_account_rec.attribute4          :=  p_attribute4;
 l_cust_account_rec.attribute5          :=  p_attribute5;
 l_cust_account_rec.attribute6          :=  p_attribute6;
 l_cust_account_rec.attribute9          :=  l_blind_shipments ;--p_attribute9; --blind_shipment
 --l_cust_account_rec.profile_class_id    := p_profile_class_id;
l_step:= 'Call API';
dbms_output.put_line(l_step);       
 hz_cust_account_v2pub.create_cust_account(
       p_init_msg_list          => Fnd_Api.g_true,
       p_cust_account_rec       => l_cust_account_rec,
       p_organization_rec       => l_organization_rec,
       p_customer_profile_rec   => l_cust_profile_rec,
       --p_create_profile_amt     => l_create_profile_amt,
       x_cust_account_id        => x_cust_account_id,
       x_account_number         => x_account_number,
       x_party_id               => x_party_id,
       x_party_number           => x_party_number,
       x_profile_id             => x_cust_profile_id,
       x_return_status          => x_return_status,
       x_msg_count              => x_msg_count,
       x_msg_data               => x_msg_data);       

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_cust_account_id: '||x_cust_account_id);
 dbms_output.put_line('x_account_number: '||x_account_number);
 dbms_output.put_line('x_party_id: '||x_party_id);
 dbms_output.put_line('x_party_number: '||x_party_number);
 dbms_output.put_line('x_profile_id: '||x_cust_profile_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
          --  dbms_output.put_line(l_err_desc);
            END LOOP;
           dbms_output.put_line(l_err_desc); 
        END IF;
   END IF;
   
    
--IF  x_ret_status =  FND_API.G_RET_STS_SUCCESS THEN 
  lx_acct_status         :=x_return_status;
  lx_party_id      :=x_party_id;
  lx_cust_acct_id  :=x_cust_account_id;
  lx_cust_profile_id :=x_cust_profile_id;
---ELSE  
--  p_status :=x_ret_status;
--END IF;  
EXCEPTION
 WHEN OTHERS THEN 
    dbms_output.put_line('Error in Step -'||l_step);
END;    

---++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--Create Location
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
l_step:= 'Create Bill To Location';
dbms_output.put_line(l_step);
IF  lx_acct_status = 'S' THEN  
BEGIN
   l_location_rec.country := p_b_country;
   l_location_rec.address1 := p_b_address1;
   l_location_rec.address2 := p_b_address2;
   l_location_rec.address3 := p_b_address3;
   l_location_rec.city    := p_b_city;
   l_location_rec.postal_code := p_b_postal_code;
   l_location_rec.state := p_b_state;
   l_location_rec.province:=p_b_province;
   l_location_rec.created_by_module := g_created_by_module;
   
   hz_location_v2pub.create_location
     (
      p_init_msg_list     => 'T',
      p_location_rec      => l_location_rec,
      x_location_id       => x_location_id,
      x_return_status     => x_return_status,
      x_msg_count         => x_msg_count,
      x_msg_data          => x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_location_id: '||x_location_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           --dbms_output.put_line(l_err_desc);
            END LOOP;
          dbms_output.put_line(l_err_desc);  
        END IF;
   END IF;
 
 lx_bloc_status :=x_return_status;
 l_b_location_id :=x_location_id;
END; 
END IF;
l_step:= 'Create Ship To Location';
dbms_output.put_line(l_step);

IF  lx_acct_status = 'S' THEN  
BEGIN
IF p_bill_ship_site_same  ='Y' THEN 
   l_location_rec.country := p_b_country;
   l_location_rec.address1 := p_b_address1;
   l_location_rec.address2 := p_b_address2;
   l_location_rec.address3 := p_b_address3;
   l_location_rec.city    := p_b_city;
   l_location_rec.postal_code := p_b_postal_code;
   l_location_rec.state := p_b_state;
   l_location_rec.province:=p_b_province;
   l_location_rec.created_by_module := g_created_by_module;
ELSE
   l_location_rec.country := p_s_country;
   l_location_rec.address1 := p_s_address1;
   l_location_rec.address2 := p_s_address2;
   l_location_rec.address3 := p_s_address3;
   l_location_rec.city    := p_s_city;
   l_location_rec.postal_code := p_s_postal_code;
   l_location_rec.state := p_s_state;
   l_location_rec.province:=p_s_province;
   l_location_rec.created_by_module := g_created_by_module;
END IF;   
   hz_location_v2pub.create_location
     (
      p_init_msg_list     => 'T',
      p_location_rec      => l_location_rec,
      x_location_id       => x_location_id,
      x_return_status     => x_return_status,
      x_msg_count         => x_msg_count,
      x_msg_data          => x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_location_id: '||x_location_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           --dbms_output.put_line(l_err_desc);
            END LOOP;
          dbms_output.put_line(l_err_desc);  
        END IF;
   END IF;
 
 lx_sloc_status :=x_return_status;
 l_s_location_id :=x_location_id;
END; 
END IF;

l_step:='Create Bill To Site';
dbms_output.put_line(l_step);
IF  lx_acct_status = 'S' and lx_bloc_status = 'S' THEN
BEGIN
   l_party_site_rec.party_id := lx_party_id; --<<value for party_id from step 2>
   l_party_site_rec.location_id := l_b_location_id; --<<value for location_id from step 3>
   ----
   l_party_site_rec.identifying_address_flag := 'Y';
   ----
   l_party_site_rec.created_by_module := g_created_by_module;
    hz_party_site_v2pub.create_party_site(
     'T',
     l_party_site_rec,
     x_party_site_id,
     x_party_site_number,
     x_return_status,
     x_msg_count,
     x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_party_site_id: '||x_party_site_id);
 dbms_output.put_line('x_party_site_number: '||x_party_site_number);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 
   IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           --dbms_output.put_line(l_err_desc);
            END LOOP;
            dbms_output.put_line(l_err_desc);
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);
 lx_bsite_status  := x_return_status;
 l_bparty_site_id:= x_party_site_id;
END; 
END IF;

l_step:='Create Ship To Site';
dbms_output.put_line(l_step);
IF  lx_acct_status = 'S' and lx_sloc_status = 'S' THEN
BEGIN
   l_party_site_rec.party_id := lx_party_id; --<<value for party_id from step 2>
   l_party_site_rec.location_id := l_s_location_id; --<<value for location_id from step 3>
   ----
   l_party_site_rec.identifying_address_flag := 'N';
   ----
   l_party_site_rec.created_by_module := g_created_by_module;
    hz_party_site_v2pub.create_party_site(
     'T',
     l_party_site_rec,
     x_party_site_id,
     x_party_site_number,
     x_return_status,
     x_msg_count,
     x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_party_site_id: '||x_party_site_id);
 dbms_output.put_line('x_party_site_number: '||x_party_site_number);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 
   IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           --dbms_output.put_line(l_err_desc);
            END LOOP;
            dbms_output.put_line(l_err_desc);
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);
 lx_ssite_status  := x_return_status;
 l_sparty_site_id:= x_party_site_id;
END; 
END IF;

l_step:='Create Bill To  Account- Site';
dbms_output.put_line(l_step);
dbms_output.put_line(lx_acct_status||'--'||lx_bloc_status||'--'||lx_bsite_status);
IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' THEN 
BEGIN
 p_cust_acct_site_rec.cust_account_id := lx_cust_acct_id;--12722; 
 p_cust_acct_site_rec.party_site_id := l_bparty_site_id;--12164;
 --p_cust_acct_site_rec.language := 'US';
 fnd_global.apps_initialize ( user_id      => 7614
                            ,resp_id      => 21623
                            ,resp_appl_id => 660);
 mo_global.init ( 'AR' ) ;
 mo_global.set_policy_context ('S', P_ORG_ID ) ;
 --mo_global.set_policy_context ( 'S', '3' ) ;
 p_cust_acct_site_rec.org_id :=p_org_id;
 p_cust_acct_site_rec.created_by_module := g_created_by_module;
 hz_cust_account_site_v2pub.create_cust_acct_site(
 'T',
 p_cust_acct_site_rec,
 x_cust_acct_site_id,
 x_return_status,
 x_msg_count,
 x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_cust_acct_site_id: '||x_cust_acct_site_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           
            END LOOP;
            dbms_output.put_line(l_err_desc);
        END IF;
   END IF;
 lx_ba_site_status:=x_return_status;
 l_cust_acct_bsite_id := x_cust_acct_site_id;
END ;
END IF;
---????????????????????????????????????
--END;
l_step:='Create Ship To  Account- Site';
dbms_output.put_line(l_step);
IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' THEN 
BEGIN
 p_cust_acct_site_rec.cust_account_id := lx_cust_acct_id;--12722; 
 p_cust_acct_site_rec.party_site_id := l_sparty_site_id;--12164;
 --p_cust_acct_site_rec.language := 'US';
 fnd_global.apps_initialize ( user_id      => 7614
                            ,resp_id      => 21623
                            ,resp_appl_id => 660);
 mo_global.init ( 'AR' ) ;
 mo_global.set_policy_context ('S', P_ORG_ID ) ;
 --mo_global.set_policy_context ( 'S', '3' ) ;
 p_cust_acct_site_rec.org_id :=p_org_id;
 p_cust_acct_site_rec.created_by_module := g_created_by_module;
 hz_cust_account_site_v2pub.create_cust_acct_site(
 'T',
 p_cust_acct_site_rec,
 x_cust_acct_site_id,
 x_return_status,
 x_msg_count,
 x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_cust_acct_site_id: '||x_cust_acct_site_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           
            END LOOP;
            dbms_output.put_line(l_err_desc);
        END IF;
   END IF;
 lx_sa_site_status :=x_return_status;
 l_cust_acct_ssite_id := x_cust_acct_site_id;
END ;
END IF;
----------
l_step:= 'Calling Addiitonal Attribute Validations for Site';
dbms_output.put_line(l_step);
----------------------------------------------------
--Derive Price List Name
l_step:='Derive Price List Name';
dbms_output.put_line(l_step);
BEGIN
SELECT list_header_id
  INTO l_list_header_id
  FROM qp_list_headers_all
 WHERE name =  p_price_list_name 
   AND sysdate between NVL(start_date_active,sysdate) and NVL(end_date_active,sysdate)
   AND list_type_code ='PRL';
 dbms_output.put_line('price List ID -'|| l_list_header_id); 
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Price List details found');
    l_list_header_id:= NULL;
END;

l_step:='Derive Order Type';
dbms_output.put_line(l_step);
BEGIN
SELECT t.transaction_type_id  
  INTO l_order_type_id
  FROM oe_transaction_types_all t,oe_transaction_types_tl tl
 WHERE t.transaction_type_code  = 'ORDER' 
   AND t.transaction_type_id = tl.transaction_type_id
   AND tl.language = userenv('LANG')
   and tl.name = p_order_type;
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Order Type details found');
    l_order_type_id:= NULL;
END;
/*
l_step:='Derive Customer Class';
dbms_output.put_line(l_step);
BEGIN
SELECT lookup_code
INTO   l_customer_class_code
FROM ar_lookups
WHERE lookup_type like 'CUSTOMER CLASS'
AND (UPPER(p_customer_class) = UPPER(MEANING) or UPPER(p_customer_class) = UPPER(LOOKUP_CODE))
AND sysdate between NVL(start_date_active,sysdate) and NVL(end_date_active,sysdate);
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('No Valid Customer Class details found');
    l_customer_class_code:= NULL;
END;
*/
l_step:='Derive Site Sales Rep';
dbms_output.put_line(l_step);
BEGIN
SELECT ra.salesrep_id--UPPER(res.source_first_name)||' '||UPPER(res.source_last_name)--salesrep_name
  INTO l_salesrep_id
  FROM apps.jtf_rs_resource_extns_vl res, apps.ra_salesreps_all ra
 WHERE UPPER(ra.name) = UPPER(p_salesrep)
 --UPPER(res.source_first_name)||' '||UPPER(res.source_last_name) = UPPER(p_salesrep)
   AND res.resource_id = ra.resource_id;
                                  
EXCEPTION 
  WHEN OTHERS THEN 
    dbms_output.put_line('Not Valid Sales Rep');
    l_salesrep_id:= NULL;
END;


l_step:='Derive Site Ship Set';
dbms_output.put_line(l_step);
BEGIN

 SELECT lookup_code
   INTO l_site_ship_set
   FROM ar_lookups
  WHERE lookup_type = 'YES/NO'
    AND (UPPER(lookup_code) = UPPER(decode(p_ship_set,'false','N','true','Y',NULL))
    OR UPPER(meaning) = UPPER(decode(p_ship_set,'false','No','true','Yes',NULL)))
    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
    AND enabled_flag = 'Y';
    dbms_output.put_line('Ship Set -'||l_ship_set);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Ship Set');
    l_ship_set:='N';
END ;

l_step:='Derive Site Blind Shipment';
dbms_output.put_line(l_step);
BEGIN

 SELECT Decode (lookup_code,'YES','Y','No','N',NULL)
   INTO l_site_blind_shipments
                   FROM oe_lookups
                  WHERE lookup_type = 'OM_YES_NO'
                    AND (UPPER(lookup_code) = UPPER(p_blind_shipments) OR UPPER(meaning) = UPPER(p_blind_shipments))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y';
    dbms_output.put_line(' Site Blind Shipment  -'||l_site_blind_shipments);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Value for Bline Shipment');
    l_blind_shipments:= NULL;
END ;

l_step:='Derive Site FOB';
dbms_output.put_line(l_step);
BEGIN
  SELECT lookup_code
    INTO l_site_fob_code
                   FROM ar_lookups
                  WHERE lookup_type = 'FOB'
                    AND (UPPER(lookup_code) = UPPER(p_fob_code) OR UPPER(meaning) = UPPER(p_fob_code))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y'; 
                    dbms_output.put_line(' l_fob_code >>>>  -'||l_fob_code);
                    
EXCEPTION 
 WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid fob');
    l_fob_code:=NULL;
END;

l_step:='Derive PShip Via';
dbms_output.put_line(l_step);                    
BEGIN                   
SELECT lookup_code
  INTO l_site_ship_via
  FROM apps.oe_ship_methods_v
 WHERE (UPPER(lookup_code) = UPPER(p_ship_via_code) OR UPPER(meaning) = UPPER(p_ship_via_code))
   AND enabled_flag = 'Y'   ;
   dbms_output.put_line(' Ship Via  -'||l_ship_via);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Ship Via ');
    l_ship_via:=NULL;
END; 

l_step:='Derive Site Freight Terms';
dbms_output.put_line(l_step);
BEGIN
 SELECT lookup_code
   INTO l_site_freight_terms
   FROM so_lookups
  WHERE lookup_type = 'FREIGHT_TERMS'
    AND (UPPER(lookup_code) = UPPER(p_freight_terms) OR UPPER(meaning) = UPPER(p_freight_terms))
    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
    AND enabled_flag = 'Y';
    dbms_output.put_line('Freight term - '||l_freight_terms);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Freight terms');
  l_freight_terms:=NULL;
END; 

l_step:='Derive Site Sales Channel';
dbms_output.put_line(l_step);
BEGIN
        SELECT lookup_code
                   into l_site_sales_channel
                   FROM so_lookups
                  WHERE lookup_type = 'SALES_CHANNEL'
                    AND (UPPER(lookup_code) = UPPER(p_sales_channel) OR UPPER(meaning) = UPPER(p_sales_channel))
                    AND SYSDATE BETWEEN NVL(start_date_active, SYSDATE) AND NVL(end_date_active, SYSDATE)
                    AND enabled_flag = 'Y' ;
                    dbms_output.put_line('Sales channel >>>> '||l_sales_channel);
EXCEPTION 
  WHEN OTHERS THEN 
  dbms_output.put_line('Not Valid Sales Channel');
     l_sales_channel:= NULL;
END;
----------

IF lx_ba_site_status  = 'S' THEN
l_step:='Create Account Site USE - BILL-TO';
dbms_output.put_line(l_step);
BEGIN
 p_cust_site_use_rec.cust_acct_site_id := l_cust_acct_bsite_id; 
 p_cust_site_use_rec.site_use_code := 'BILL_TO';
 p_cust_site_use_rec.primary_salesrep_id :=l_salesrep_id;
 p_cust_site_use_rec.order_type_id := l_order_type_id;
 p_cust_site_use_rec.price_list_id := l_list_header_id;
 
 --p_cust_site_use_rec.customer_class_code :=  p_customer_class_code;
 p_cust_site_use_rec.fob_point           :=  l_site_fob_code;
 p_cust_site_use_rec.freight_term        :=  l_site_freight_terms;
-- p_cust_site_use_rec.sales_channel_code  :=  p_site_sales_channel;
 p_cust_site_use_rec.ship_via            :=  l_site_ship_via;
 p_cust_site_use_rec.SHIP_SETS_INCLUDE_LINES_FLAG := l_site_ship_set;
 --p_cust_site_use_rec.attribute1          :=  p_attribute1;
 --p_cust_site_use_rec.attribute2          :=  p_attribute2;
 --p_cust_site_use_rec.attribute3          :=  p_attribute3;
 --p_cust_site_use_rec.attribute4          :=  p_attribute4;
 --p_cust_site_use_rec.attribute5          :=  p_attribute5;
 --p_cust_site_use_rec.attribute6          :=  p_attribute6;
 p_cust_site_use_rec.attribute9          :=  l_site_blind_shipments ;
 
--  IF p_bill_to_site_use_id is NOT NULL THEN 
--  p_cust_site_use_rec.bill_to_site_use_id:= p_bill_to_site_use_id;
-- END IF; 
 p_cust_site_use_rec.created_by_module := g_created_by_module;
 hz_cust_account_site_v2pub.create_cust_site_use(
 'T',
 p_cust_site_use_rec,
 p_customer_profile_rec,
 '',
 '',
 x_site_use_id,
 x_return_status,
 x_msg_count,
 x_msg_data);
 --p_status := x_return_status;
 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_site_use_id: '||x_site_use_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_count);
 dbms_output.put_line('***************************');
 
  IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);
  lx_ba_site_use_status:= x_return_status;  
  l_bill_site_use_id:=x_site_use_id;

END ;
END IF;

IF lx_sa_site_status  = 'S' THEN
l_step:='Create Account Site USE - SHIP-TO';
dbms_output.put_line(l_step);
BEGIN

 IF l_bill_site_use_id is NOT NULL THEN 
  p_cust_site_use_rec.bill_to_site_use_id:= l_bill_site_use_id;
 END IF;
 p_cust_site_use_rec.cust_acct_site_id := l_cust_acct_ssite_id; 
 p_cust_site_use_rec.site_use_code := 'SHIP_TO';
 p_cust_site_use_rec.primary_salesrep_id :=l_salesrep_id;
 p_cust_site_use_rec.order_type_id := l_order_type_id;
 p_cust_site_use_rec.price_list_id := l_list_header_id;
 
 --p_cust_site_use_rec.customer_class_code :=  p_customer_class_code;
 p_cust_site_use_rec.fob_point           :=  l_site_fob_code;
 p_cust_site_use_rec.freight_term        :=  l_site_freight_terms;
-- p_cust_site_use_rec.sales_channel_code  :=  p_site_sales_channel;
 p_cust_site_use_rec.ship_via            :=  l_site_ship_via;
 p_cust_site_use_rec.SHIP_SETS_INCLUDE_LINES_FLAG := l_site_ship_set;
 --p_cust_site_use_rec.attribute1          :=  p_attribute1;
 --p_cust_site_use_rec.attribute2          :=  p_attribute2;
 --p_cust_site_use_rec.attribute3          :=  p_attribute3;
 --p_cust_site_use_rec.attribute4          :=  p_attribute4;
 --p_cust_site_use_rec.attribute5          :=  p_attribute5;
 --p_cust_site_use_rec.attribute6          :=  p_attribute6;
 p_cust_site_use_rec.attribute9          :=  l_site_blind_shipments ;
 
--  IF p_bill_to_site_use_id is NOT NULL THEN 
--  p_cust_site_use_rec.bill_to_site_use_id:= p_bill_to_site_use_id;
-- END IF; 
 p_cust_site_use_rec.created_by_module := g_created_by_module;
 hz_cust_account_site_v2pub.create_cust_site_use(
 'T',
 p_cust_site_use_rec,
 p_customer_profile_rec,
 '',
 '',
 x_site_use_id,
 x_return_status,
 x_msg_count,
 x_msg_data);
 --p_status := x_return_status;
 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_site_use_id: '||x_site_use_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_count);
 dbms_output.put_line('***************************');
 
  IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
           
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);
  lx_ba_site_use_status:= x_return_status;  
  l_ship_site_use_id:=x_site_use_id;

END ;
END IF;

-------------------------

IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' and lx_ba_site_status ='S' THEN 
l_step:='Create  Contact at BILL Site';
dbms_output.put_line(l_step);
BEGIN
 p_create_person_rec.person_pre_name_adjunct := p_pre_cbname_adjunct;
 p_create_person_rec.person_first_name := p_cbfirst_name;
 p_create_person_rec.person_last_name := p_cblast_name;
 p_create_person_rec.created_by_module := g_created_by_module;

 HZ_PARTY_V2PUB.create_person(
 'T',
 p_create_person_rec,
 x_cbparty_id,
 x_cbparty_number,
 x_cbprofile_id,
 x_return_status,
 x_msg_count,
 x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_party_id: '||x_cbparty_id);
 dbms_output.put_line('x_party_number: '||x_cbparty_number);
 dbms_output.put_line('x_profile_id: '||x_cbprofile_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);   
lx_bcontact_status:= x_return_status; 
l_bcparty_id:= x_cbparty_id;

END;  
END IF;


IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' THEN 
l_step:='Create  Contact at Ship Site';
dbms_output.put_line(l_step);
BEGIN
 p_create_person_rec.person_pre_name_adjunct := p_pre_csname_adjunct;
 p_create_person_rec.person_first_name := p_csfirst_name;
 p_create_person_rec.person_last_name := p_cslast_name;
 p_create_person_rec.created_by_module := g_created_by_module;

 HZ_PARTY_V2PUB.create_person(
 'T',
 p_create_person_rec,
 x_csparty_id,
 x_csparty_number,
 x_csprofile_id,
 x_return_status,
 x_msg_count,
 x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_party_id: '||x_csparty_id);
 dbms_output.put_line('x_party_number: '||x_csparty_number);
 dbms_output.put_line('x_profile_id: '||x_csprofile_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);   
lx_scontact_status:= x_return_status; 
l_scparty_id:= x_csparty_id;

END;  
END IF;

-----------------------------------------------------------------------
IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' and lx_ba_site_status ='S' and lx_bcontact_status ='S' THEN 
l_step:='Create  Bill Contact Relation Ship';
dbms_output.put_line(l_step);
dbms_output.put_line('lx_party_id - '||lx_party_id);
BEGIN
--p_org_contact_rec.department_code := 'ACCOUNTING';
--p_org_contact_rec.job_title := 'APC';
--p_org_contact_rec.decision_maker_flag := 'Y';
--p_org_contact_rec.job_title_code := 'APC';
p_org_contact_rec.created_by_module := g_created_by_module;
p_org_contact_rec.party_rel_rec.subject_id := l_bcparty_id;--27094; --<<value for party_id from step 7>
p_org_contact_rec.party_rel_rec.subject_type := 'PERSON';
p_org_contact_rec.party_rel_rec.subject_table_name := 'HZ_PARTIES';
p_org_contact_rec.party_rel_rec.object_id := lx_party_id;--27093; --<<value for party_id from step 2>
p_org_contact_rec.party_rel_rec.object_type := 'ORGANIZATION';
p_org_contact_rec.party_rel_rec.object_table_name := 'HZ_PARTIES';
p_org_contact_rec.party_rel_rec.relationship_code := 'CONTACT_OF';
p_org_contact_rec.party_rel_rec.relationship_type := 'CONTACT';
p_org_contact_rec.party_rel_rec.start_date := SYSDATE;
--p_org_contact_rec.party_rel_rec.party_rec.party_number := '0012277';
--p_org_contact_rec.contact_NUMber := '0012266';

hz_party_contact_v2pub.create_org_contact(
'T',
p_org_contact_rec,
x_borg_contact_id,
x_bparty_rel_id,
x_brparty_id,
x_brparty_number,
x_return_status,
x_msg_count,
x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_org_contact_id: '||x_borg_contact_id);
 dbms_output.put_line('x_party_rel_id: '||x_bparty_rel_id);
 dbms_output.put_line('x_party_id: '||x_brparty_id);
 dbms_output.put_line('x_party_number: '||x_brparty_number);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_brel_status :=x_return_status;
l_brel_party_id:=x_brparty_id;
END;
END IF;

-------------------------------------------------------
IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' and lx_scontact_status ='S' THEN 
l_step:='Create Ship Contact Relation Ship';
dbms_output.put_line(l_step);
dbms_output.put_line('lx_party_id - '||lx_party_id);
BEGIN
--p_org_contact_rec.department_code := 'ACCOUNTING';
--p_org_contact_rec.job_title := 'APC';
--p_org_contact_rec.decision_maker_flag := 'Y';
--p_org_contact_rec.job_title_code := 'APC';
p_org_contact_rec.created_by_module := g_created_by_module;
p_org_contact_rec.party_rel_rec.subject_id := l_scparty_id;--27094; --<<value for party_id from step 7>
p_org_contact_rec.party_rel_rec.subject_type := 'PERSON';
p_org_contact_rec.party_rel_rec.subject_table_name := 'HZ_PARTIES';
p_org_contact_rec.party_rel_rec.object_id := lx_party_id;--27093; --<<value for party_id from step 2>
p_org_contact_rec.party_rel_rec.object_type := 'ORGANIZATION';
p_org_contact_rec.party_rel_rec.object_table_name := 'HZ_PARTIES';
p_org_contact_rec.party_rel_rec.relationship_code := 'CONTACT_OF';
p_org_contact_rec.party_rel_rec.relationship_type := 'CONTACT';
p_org_contact_rec.party_rel_rec.start_date := SYSDATE;
--p_org_contact_rec.party_rel_rec.party_rec.party_number := '0012277';
--p_org_contact_rec.contact_NUMber := '0012266';

hz_party_contact_v2pub.create_org_contact(
'T',
p_org_contact_rec,
x_sorg_contact_id,
x_sparty_rel_id,
x_srparty_id,
x_srparty_number,
x_return_status,
x_msg_count,
x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_org_contact_id: '||x_sorg_contact_id);
 dbms_output.put_line('x_party_rel_id: '||x_sparty_rel_id);
 dbms_output.put_line('x_party_id: '||x_srparty_id);
 dbms_output.put_line('x_party_number: '||x_srparty_number);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_srel_status :=x_return_status;
l_srel_party_id:=x_srparty_id;
END;
END IF;

---------------------------------------------------------------------

IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' and lx_ba_site_status ='S' 
and lx_bcontact_status ='S' and lx_brel_status = 'S' THEN 
l_step:='Create Bill to Contact Role';
dbms_output.put_line(l_step);
BEGIN

-- NOTE:
-- must be unique CUST_ACCOUNT_ID, PARTY_ID,ROLE_TYPE 
-- must be unique CUST_ACCT_SITE_ID, PARTY_ID,ROLE_TYPE
p_cr_cust_acc_role_rec.party_id := l_brel_party_id;--11339; 
p_cr_cust_acc_role_rec.cust_account_id := lx_cust_acct_id;--10033; 
--IF p_contact_level = 'ACCOUNT' THEN 
--p_cr_cust_acc_role_rec.cust_acct_site_id := NULL;
--ELSIF   p_contact_level = 'SITE' THEN 
p_cr_cust_acc_role_rec.cust_acct_site_id := l_cust_acct_bsite_id;
--END IF;
p_cr_cust_acc_role_rec.primary_flag := 'Y';
p_cr_cust_acc_role_rec.role_type := 'CONTACT';
p_cr_cust_acc_role_rec.created_by_module := g_created_by_module;

HZ_CUST_ACCOUNT_ROLE_V2PUB.create_cust_account_role(
'T',
p_cr_cust_acc_role_rec,
x_cust_account_brole_id,
x_return_status,
x_msg_count,
x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_cust_account_role_id: '||x_cust_account_brole_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_brole_status :=x_return_status;
l_cust_acc_brole_id :=x_cust_account_brole_id;
END;
END IF;


IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' 
and lx_scontact_status ='S' and lx_srel_status = 'S' THEN 
l_step:='Create Ship to Contact Role';
dbms_output.put_line(l_step);
BEGIN
p_cr_cust_acc_role_rec.party_id := l_srel_party_id;--11339; 
p_cr_cust_acc_role_rec.cust_account_id := lx_cust_acct_id;--10033; 
--IF p_contact_level = 'ACCOUNT' THEN 
--p_cr_cust_acc_role_rec.cust_acct_site_id := NULL;
--ELSIF   p_contact_level = 'SITE' THEN 
p_cr_cust_acc_role_rec.cust_acct_site_id := l_cust_acct_ssite_id;
--END IF;
p_cr_cust_acc_role_rec.primary_flag := 'Y';
p_cr_cust_acc_role_rec.role_type := 'CONTACT';
p_cr_cust_acc_role_rec.created_by_module := g_created_by_module;

HZ_CUST_ACCOUNT_ROLE_V2PUB.create_cust_account_role(
'T',
p_cr_cust_acc_role_rec,
x_cust_account_srole_id,
x_return_status,
x_msg_count,
x_msg_data);

 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_cust_account_role_id: '||x_cust_account_srole_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_srole_status :=x_return_status;
l_cust_acc_srole_id :=x_cust_account_srole_id;
END;
END IF;
---------------------------------------------------------------------
IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' and lx_ba_site_status ='S' 
and lx_bcontact_status ='S' and lx_brel_status = 'S' and lx_brole_status = 'S' THEN 

l_step:='Create Bill to Contact Point - Phone';
dbms_output.put_line(l_step);
BEGIN
  p_contact_point_rec.created_by_module :=  g_created_by_module;
  p_contact_point_rec.owner_table_name := 'HZ_PARTY_SITES';
  p_contact_point_rec.owner_table_id :=  l_bparty_site_id;
  p_contact_point_rec.contact_point_type := 'PHONE';
  p_phone_rec.phone_line_type := 'GEN';
  p_phone_rec.phone_area_code := substr(p_bphone_number,1,3);--p_phone_area_code;--'407';
  p_phone_rec.Phone_number := substr(p_bphone_number,5);
HZ_CONTACT_POINT_V2PUB.create_contact_point (
'T',
p_contact_point_rec,
p_edi_rec_type,
p_email_rec_type,
p_phone_rec,
p_telex_rec_type,
p_web_rec_type,
x_bcontact_point_id,
x_return_status,
x_msg_count,
x_msg_data
);


 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_bcontact_point_id: '||x_bcontact_point_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_bconpoint_status:=x_return_status;
l_bcontact_point_id := x_bcontact_point_id;
END;
END IF;
----------------------------------------------------------------------------
---------------------------------------------------------------------
IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' 
and lx_scontact_status ='S' and lx_srel_status = 'S' and lx_srole_status = 'S' THEN 

l_step:='Create Ship to Contact Point - Phone';
dbms_output.put_line(l_step);
BEGIN
  p_contact_point_rec.created_by_module :=  g_created_by_module;
  p_contact_point_rec.owner_table_name := 'HZ_PARTY_SITES';
  p_contact_point_rec.owner_table_id :=  l_sparty_site_id;
  p_contact_point_rec.contact_point_type := 'PHONE';
  p_phone_rec.phone_line_type := 'GEN';
  p_phone_rec.phone_area_code := substr(p_sphone_number,1,3);--p_phone_area_code;--'407';
  p_phone_rec.Phone_number := substr(p_sphone_number,5);
HZ_CONTACT_POINT_V2PUB.create_contact_point (
'T',
p_contact_point_rec,
p_edi_rec_type,
p_email_rec_type,
p_phone_rec,
p_telex_rec_type,
p_web_rec_type,
x_scontact_point_id,
x_return_status,
x_msg_count,
x_msg_data
);


 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_bcontact_point_id: '||x_scontact_point_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_sconpoint_status:=x_return_status;
l_scontact_point_id := x_scontact_point_id;
END;
END IF;
---????????????????????????????????????

IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' 
and lx_scontact_status ='S' and lx_srel_status = 'S' and lx_srole_status = 'S' THEN 

l_step:='Create Ship to Contact Point - Email';
dbms_output.put_line(l_step);
BEGIN
  p_contact_point_rec.created_by_module :=  g_created_by_module;
  p_contact_point_rec.owner_table_name := 'HZ_PARTY_SITES';
  p_contact_point_rec.owner_table_id :=  l_bparty_site_id;
  p_contact_point_rec.contact_point_type := 'EMAIL';-- for contact of type Email
  p_email_rec_type.email_format := 'MAILHTML';
  p_email_rec_type.email_address := p_semail_address;
HZ_CONTACT_POINT_V2PUB.create_contact_point (
'T',
p_contact_point_rec,
p_edi_rec_type,
p_email_rec_type,
p_phone_rec,
p_telex_rec_type,
p_web_rec_type,
x_sEcontact_point_id,
x_return_status,
x_msg_count,
x_msg_data
);


 dbms_output.put_line('***************************');
 dbms_output.put_line('Output information ....');
 dbms_output.put_line('x_bcontact_point_id: '||x_sEcontact_point_id);
 dbms_output.put_line('x_return_status: '||x_return_status);
 dbms_output.put_line('x_msg_count: '||x_msg_count);
 dbms_output.put_line('x_msg_data: '||x_msg_data);
 dbms_output.put_line('***************************');
 IF x_return_status <> 'S' THEN
       IF x_msg_count > 0 THEN
           FOR i IN 1 .. x_msg_count LOOP
           fnd_msg_pub.GET (p_msg_index     => i,
                            p_encoded       => FND_API.G_FALSE,
                            p_data          => x_msg_data,
                            p_msg_index_out => l_msg_index);
           l_err_desc := ( l_err_desc || ' ' || To_Char ( i ) || ': ' || SUBSTR(x_msg_data,1,200) );
            END LOOP;
        END IF;
   END IF;
   DBMS_OUTPUT.PUT_LINE (l_err_desc);  
lx_sEconpoint_status:=x_return_status;
l_sEcontact_point_id := x_scontact_point_id;
END;
END IF;

IF lx_acct_status = 'S' and lx_bloc_status = 'S' and  lx_bsite_status ='S' and lx_ba_site_status ='S' 
and lx_bcontact_status ='S' and lx_brel_status = 'S' and lx_brole_status = 'S' THEN 
BEGIN
l_step:='Create Bill to Role Responsibility';
dbms_output.put_line(l_step);
    p_role_responsibility_rec.cust_account_role_id := l_cust_acc_brole_id; -- value for x_cust_account_role_id from step 9 
    p_role_responsibility_rec.responsibility_type := 'BILL_TO';-- 'SOLD_TO';
    p_role_responsibility_rec.created_by_module := g_created_by_module;
    
    HZ_CUST_ACCOUNT_ROLE_V2PUB.create_role_responsibility (
    'T',
    p_role_responsibility_rec,
    x_Bresponsibility_id,
    x_return_status,
    x_msg_count,
    x_msg_data
    );

dbms_output.put_line('***************************');
dbms_output.put_line('Output information ....');
dbms_output.put_line('***************************');
dbms_output.put_line('x_responsibility_id: '||x_Bresponsibility_id);
dbms_output.put_line('x_return_status: '||x_return_status);
dbms_output.put_line('x_msg_count: '||x_msg_count);
dbms_output.put_line('x_msg_data: '||x_msg_data);
dbms_output.put_line('***************************');

  IF x_msg_count >1 THEN
    FOR I IN 1..x_msg_count
    LOOP
    dbms_output.put_line(I||'. '||SubStr(FND_MSG_PUB.Get(p_encoded => FND_API.G_FALSE ), 1, 255));
    END LOOP;
  END IF;
lx_bresp_status :=x_return_status;
--l_sEcontact_point_id := x_scontact_point_id;
END;
END IF;

IF lx_acct_status = 'S' and lx_sloc_status = 'S' and  lx_ssite_status ='S' and lx_sa_site_status ='S' 
and lx_scontact_status ='S' and lx_srel_status = 'S' and lx_srole_status = 'S' THEN 
BEGIN
l_step:='Create Ship to Role Responsibility';
dbms_output.put_line(l_step);
    
    p_role_responsibility_rec.cust_account_role_id := l_cust_acc_srole_id; -- value for x_cust_account_role_id from step 9 
    p_role_responsibility_rec.responsibility_type := 'SHIP_TO';-- 'SOLD_TO';
    p_role_responsibility_rec.created_by_module := g_created_by_module;
    
    HZ_CUST_ACCOUNT_ROLE_V2PUB.create_role_responsibility (
    'T',
    p_role_responsibility_rec,
    x_Sresponsibility_id,
    x_return_status,
    x_msg_count,
    x_msg_data
    );

dbms_output.put_line('***************************');
dbms_output.put_line('Output information ....');
dbms_output.put_line('***************************');
dbms_output.put_line('x_responsibility_id: '||x_Sresponsibility_id);
dbms_output.put_line('x_return_status: '||x_return_status);
dbms_output.put_line('x_msg_count: '||x_msg_count);
dbms_output.put_line('x_msg_data: '||x_msg_data);
dbms_output.put_line('***************************');

  IF x_msg_count >1 THEN
    FOR I IN 1..x_msg_count
    LOOP
    dbms_output.put_line(I||'. '||SubStr(FND_MSG_PUB.Get(p_encoded => FND_API.G_FALSE ), 1, 255));
    END LOOP;
  END IF;
lx_sresp_status :=x_return_status;
--l_sEcontact_point_id := x_scontact_point_id;
END;
END IF;


END;


--BEGIN
--mo_global.set_policy_context ('S', '82' ) ;
--END;

