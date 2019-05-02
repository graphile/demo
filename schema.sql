-- Extensions
create extension if not exists citext;

-- Database privileges
revoke all on database graphile_example from public;
grant connect on database graphile_example to graphql;

alter default privileges in schema public grant all on sequences to graphql;
grant all on all sequences in schema public to graphql;

create function current_user_id() returns int as $$
  -- Replace with: select nullif(current_setting('jwt.claims.user_id', true), '')::int;
  select 1;
$$ language sql stable;

comment on function current_user_id() is '@omit';

-- Users table
create table users (
  id serial primary key,
  username citext not null,
  verified boolean not null default false
);
alter table users enable row level security;
grant select on users to graphql;
create policy select_all on users for select using (true);

-- Articles table
create table articles (
  id serial primary key,
  author_id int not null default current_user_id() references users,
  title text not null,
  url text not null
);
grant select on articles to graphql;

-- Initial articles data
insert into users (username, verified) values
  ('Benjie', false),
  ('scientificracehorse', false),
  ('buzzingwheelchair', false),
  ('sweatyfootball', false),
  ('hideousmahjong', true),
  ('widerage', false),
  ('bogusrewind', false),
  ('reconditeturtle', false),
  ('neglectedsailboat', true),
  ('pleasantfeet', false),
  ('nauseatingpeach', false),
  ('crushingrestroom', false),
  ('utilizedcalendar', false),
  ('ornatetelephone', true),
  ('cluelesstaurus', false),
  ('pluckypizza', false),
  ('maturehotsprings', false),
  ('unselfishscissors', false),
  ('deliciouspeace', false),
  ('wisetaco', false),
  ('densenerd', false),
  ('similarsparkle', false),
  ('sorrowfulangry', false),
  ('auspicioussushi', false),
  ('handsomepouch', false),
  ('petulantstars', false),
  ('capriciousprojector', false),
  ('abundantcool', false),
  ('rabidboom', false),
  ('steadybutterfly', false),
  ('unsightlyup', false),
  ('spotlessmailbox', false),
  ('boilingunicorn', false),
  ('prejudicedinterrobang', false),
  ('farawayschool', false),
  ('reluctantcucumber', false),
  ('constanthorse', false),
  ('irritatingcouple', false),
  ('luminousbeers', false),
  ('flamboyantmens', false),
  ('frizzyastonished', false),
  ('stripedpisces', false),
  ('groggybank', false),
  ('nauticalscorpion', false),
  ('linedalembic', false),
  ('youngkaaba', false),
  ('secondcapricorn', false),
  ('tidypineapple', false),
  ('immodestkimono', false),
  ('inspiringweary', false),
  ('abruptregistered', false),
  ('widebirchwood', false),
  ('tidybow', false),
  ('validair', false),
  ('wretchedsnowball', false),
  ('obsoleteegg', false),
  ('sordidminecart', false),
  ('wickedleather', false),
  ('dangerousmelon', false),
  ('tolerantsand', false),
  ('verifiabletripwire', false),
  ('unarmedice', false),
  ('fairrails', false),
  ('flashycarrots', false),
  ('aberrantsulphur', false),
  ('absolutetrapdoor', false),
  ('illsandstone', false),
  ('mereblazerod', false),
  ('wholesalelilypad', false),
  ('changeableflint', false),
  ('pickyfern', false),
  ('disloyalsugarcane', false),
  ('forsakencoalore', false),
  ('absurdapple', false),
  ('sarcasticsign', false),
  ('gaseousstick', false),
  ('unfinishedladder', false),
  ('gentlevines', false),
  ('vigorousemerald', false),
  ('wholebookshelf', false),
  ('tragicsponge', false),
  ('civilfire', false),
  ('damagedtorch', false),
  ('brawnybedrock', false),
  ('boisterousmycelium', false),
  ('unpopularsaddle', false),
  ('hulkingmap', false),
  ('brashslimeball', false),
  ('sweetstring', false),
  ('fatsignpost', false),
  ('sullendandelion', false),
  ('deeplyshears', false),
  ('typicalpotatoes', false),
  ('revereddirt', false),
  ('notedclay', false),
  ('wackyjukebox', false),
  ('strictbonemeal', false),
  ('agedanvil', false),
  ('unwillingredstone', false),
  ('supremelava', false),
  ('firmsugar', false);

insert into articles (author_id, title, url) values
  (2, 'Remote Code Execution on Most Dell Computers', 'https://d4stiny.github.io/Remote-Code-Execution-on-most-Dell-computers/'),
  (3, 'd4stiny.github.io', 'https://news.ycombinator.com/from?site=d4stiny.github.io'),
  (4, 'Ask HN: Who is hiring? (May 2019)', 'https://news.ycombinator.com/item?id=19797594'),
  (5, 'Building Inclusive AI at Facebook', 'https://tech.fb.com/building-inclusive-ai-at-facebook/'),
  (6, 'fb.com', 'https://news.ycombinator.com/from?site=fb.com'),
  (7, 'A Conspiracy to Kill IE6', 'http://blog.chriszacharias.com/a-conspiracy-to-kill-ie6'),
  (8, 'chriszacharias.com', 'https://news.ycombinator.com/from?site=chriszacharias.com'),
  (9, 'CallJoy – A cloud-based phone agent for small businesses', 'https://www.blog.google/technology/area-120/calljoy-small-business-phone-technology/'),
  (10, 'blog.google', 'https://news.ycombinator.com/from?site=blog.google'),
  (11, 'Bikes, bowling balls, and the balancing act that is modern recycling (2015)', 'https://arstechnica.com/science/2018/12/recycling-matching-high-tech-materials-science-with-economics-that-work/'),
  (12, 'arstechnica.com', 'https://news.ycombinator.com/from?site=arstechnica.com'),
  (13, 'PyTorch adds new dev tools as it hits production scale', 'https://ai.facebook.com/blog/pytorch-adds-new-dev-tools-as-it-hits-production-scale/'),
  (14, 'facebook.com', 'https://news.ycombinator.com/from?site=facebook.com'),
  (15, 'Examining Carlos Ghosn and Japan''s System of ''Hostage Justice''', 'https://www.japantimes.co.jp/news/2019/04/17/national/crime-legal/examining-carlos-ghosn-japans-system-hostage-justice/'),
  (16, 'japantimes.co.jp', 'https://news.ycombinator.com/from?site=japantimes.co.jp'),
  (17, 'Close CRM (YC W11) is hiring a senior back-end engineer – 100% remote team', 'https://jobs.lever.co/close.io/592193bf-8a9c-43cf-86a1-faeb75107939?lever-origin=applied&lever-source%5B%5D=HackerNews'),
  (18, 'lever.co', 'https://news.ycombinator.com/from?site=lever.co'),
  (19, 'UK Defence Secretary Gavin Williamson Sacked over Huawei Leak', 'https://www.bbc.com/news/uk-politics-48126974'),
  (20, 'bbc.com', 'https://news.ycombinator.com/from?site=bbc.com'),
  (21, 'The Race to Develop the Moon', 'https://www.newyorker.com/magazine/2019/05/06/the-race-to-develop-the-moon'),
  (22, 'newyorker.com', 'https://news.ycombinator.com/from?site=newyorker.com'),
  (23, 'European universities dismal at reporting results of clinical trials', 'https://www.nature.com/articles/d41586-019-01389-y'),
  (24, 'nature.com', 'https://news.ycombinator.com/from?site=nature.com'),
  (25, 'The PipelineDB Team (YC W14) Joins Confluent', 'https://www.confluent.io/blog/pipelinedb-team-joins-confluent'),
  (26, 'confluent.io', 'https://news.ycombinator.com/from?site=confluent.io'),
  (27, 'I Dream of Canteens', 'https://dinnerdocument.com/2019/04/30/i-dream-of-canteens/'),
  (28, 'dinnerdocument.com', 'https://news.ycombinator.com/from?site=dinnerdocument.com'),
  (29, 'The Mobile-Home Trap (2015)', 'https://www.seattletimes.com/business/real-estate/the-mobile-home-trap-how-a-warren-buffett-empire-preys-on-the-poor/'),
  (30, 'seattletimes.com', 'https://news.ycombinator.com/from?site=seattletimes.com'),
  (5, 'Facebook''s Zuckerberg Preaches Privacy, but Evidence Is Elusive', 'https://www.bloomberg.com/news/articles/2019-05-01/facebook-s-zuckerberg-preaches-privacy-but-evidence-is-elusive'),
  (32, 'bloomberg.com', 'https://news.ycombinator.com/from?site=bloomberg.com'),
  (33, 'Sole Survivors: Solo Ventures Versus Founding Teams (2018)', 'https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3107898'),
  (34, 'ssrn.com', 'https://news.ycombinator.com/from?site=ssrn.com'),
  (35, 'The hyper-specialist shops of Berlin', 'https://www.theguardian.com/cities/2019/apr/29/are-the-hyper-specialist-shops-of-berlin-the-future-of-retail'),
  (36, 'theguardian.com', 'https://news.ycombinator.com/from?site=theguardian.com'),
  (37, 'On Monks and Email', 'http://www.calnewport.com/blog/2019/04/29/on-monks-and-email/'),
  (38, 'calnewport.com', 'https://news.ycombinator.com/from?site=calnewport.com'),
  (39, 'Nasa Says Metals Fraud Caused $700M Satellite Failure', 'https://www.bloomberg.com/news/articles/2019-05-01/nasa-says-aluminum-fraud-caused-700-million-satellite-failures'),
  (40, 'bloomberg.com', 'https://news.ycombinator.com/from?site=bloomberg.com'),
  (41, 'Y Combinator''s Essential Startup Advice – Michael Seibel [video]', 'https://www.youtube.com/watch?v=A35jCapHmug'),
  (42, 'youtube.com', 'https://news.ycombinator.com/from?site=youtube.com'),
  (43, 'Anki Shutting Down', 'https://www.vox.com/2019/4/29/18522966/anki-robot-cozmo-staff-layoffs-robotics-toys-boris-sofman'),
  (44, 'vox.com', 'https://news.ycombinator.com/from?site=vox.com'),
  (45, 'IsometricSass – Sass library to make isometric 2D without JavaScript', 'https://github.com/MorganCaron/IsometricSass'),
  (46, 'github.com', 'https://news.ycombinator.com/from?site=github.com'),
  (47, 'Everyone claims they are following “agile methods” but few do (2018)', 'https://qz.com/work/1201384/everyone-claims-they-are-following-agile-methods-but-few-actually-do/'),
  (48, 'qz.com', 'https://news.ycombinator.com/from?site=qz.com'),
  (49, 'Form of dementia that ‘mimics’ Alzheimer''s symptoms discovered', 'https://www.theguardian.com/society/2019/apr/30/dementia-mimics-alzheimers-late-symptoms-discovered'),
  (50, 'theguardian.com', 'https://news.ycombinator.com/from?site=theguardian.com'),
  (51, 'Françoise Sagan, The Art of Fiction No. 15 (1956)', 'https://www.theparisreview.org/interviews/4912/francoise-sagan-the-art-of-fiction-no-15-francoise-sagan'),
  (52, 'theparisreview.org', 'https://news.ycombinator.com/from?site=theparisreview.org'),
  (53, 'The Peter Principle Tested', 'https://marginalrevolution.com/marginalrevolution/2019/05/the-peter-principle-tested.html'),
  (54, 'marginalrevolution.com', 'https://news.ycombinator.com/from?site=marginalrevolution.com'),
  (55, 'Questions About Food and Climate Change, Answered', 'https://www.nytimes.com/interactive/2019/04/30/dining/climate-change-food-eating-habits.html'),
  (56, 'nytimes.com', 'https://news.ycombinator.com/from?site=nytimes.com'),
  (57, 'Tokyo''s Underground Discharge Channel', 'https://en.wikipedia.org/wiki/Metropolitan_Area_Outer_Underground_Discharge_Channel'),
  (58, 'wikipedia.org', 'https://news.ycombinator.com/from?site=wikipedia.org'),
  (5, 'A Facebook request: Write a code of tech ethics', 'https://www.latimes.com/opinion/op-ed/la-oe-godwin-technology-ethics-20190430-story.html'),
  (60, 'latimes.com', 'https://news.ycombinator.com/from?site=latimes.com'),
  (61, 'More', 'https://news.ycombinator.com/news?p=2');
