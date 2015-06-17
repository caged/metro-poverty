CREATE TABLE tract_data(
	"tractid" bigint NOT NULL,
	"state" text NOT NULL,
	"county" text NOT NULL,
	"tract" text NOT NULL,
	"countyt_fi" bigint NOT NULL,
	"cbsa_num" bigint NOT NULL,
	"cbsa_title" text NOT NULL,
	"coredistm" decimal NOT NULL,
	"pop10" bigint NOT NULL,
	"pop00" decimal NOT NULL,
	"pop90" decimal NOT NULL,
	"pop80" decimal NOT NULL,
	"pop70" decimal NOT NULL,
	"npov10" bigint NOT NULL,
	"npov00" decimal NOT NULL,
	"npov90" decimal NOT NULL,
	"npov80" decimal NOT NULL,
	"npov70" decimal NOT NULL,
	"dpov10" bigint NOT NULL,
	"dpov00" decimal NOT NULL,
	"dpov90" decimal NOT NULL,
	"dpov80" decimal NOT NULL,
	"dpov70" decimal NOT NULL,
	"pov10rate" decimal NOT NULL,
	"pov00rate" decimal NOT NULL,
	"pov90rate" decimal NOT NULL,
	"pov80rate" decimal NOT NULL,
	"pov70rate" decimal NOT NULL,
	"calcpov10" decimal NOT NULL,
	"calcpov00" decimal NOT NULL,
	"calcpov90" decimal NOT NULL,
	"calcpov80" decimal NOT NULL,
	"calcpov70" decimal NOT NULL,
	"rebounded" text NOT NULL,
	"less_poor" text NOT NULL,
	"chronically_poor" text NOT NULL,
	"newly_poor" text NOT NULL,
	"fallen_star" text NOT NULL
)
WITH (
  OIDS=FALSE
);
