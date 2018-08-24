alter table ARM_LOYALTY_RULE
    modify POINTS decimal(6,2);

alter table ARM_SIZE
    drop PRIMARY KEY;

alter table ARM_SIZE
    add PRIMARY KEY (ID_SIZE, SIZE_INDEX, ED_CO, ED_LA);