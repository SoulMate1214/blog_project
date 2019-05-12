create table sys_classify
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) not null comment '分类名称',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '修改日期',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者'
)
  comment '文章分类';

create table sys_article
(
  id           int auto_increment comment '编号'
    primary key,
  name         varchar(255)   not null comment '文章名',
  message      varchar(15000) not null comment '文章内容',
  browse_count int default 0  not null comment '浏览量，默认0',
  like_count   int default 0  not null comment '点赞数',
  classify_id  int            not null comment '文章分类编号',
  sort         int            null comment '排序',
  status       int            null comment '状态',
  remark       varchar(255)   null comment '备注',
  is_enable    tinyint        null comment '是否启用',
  create_time  date           null comment '创建日期',
  modify_time  date           null comment '修改日期',
  create_user  varchar(255)   null comment '创建者',
  modify_user  varchar(255)   null comment '修改者',
  constraint article_classify_fk
    foreign key (classify_id) references sys_classify (id)
)
  comment '文章';

create table sys_discuss
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(11)    null comment '名称',
  parent_id   int            not null comment '父级编号',
  article_id  int            not null comment '文章编号',
  message     varchar(10000) not null comment '评论内容',
  sort        int            null comment '排序',
  status      int            null comment '状态',
  remark      varchar(255)   null comment '备注',
  is_enable   tinyint        null comment '是否启用',
  create_time date           null comment '创建日期',
  modify_time date           null comment '修改日期',
  create_user varchar(255)   null comment '创建者',
  modify_user varchar(255)   null comment '修改者',
  constraint discuss_article_fk
    foreign key (article_id) references sys_article (id),
  constraint discuss_parent_fk
    foreign key (parent_id) references sys_discuss (id)
)
  comment '评论表';

create table sys_file
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) not null comment '文件名',
  url         varchar(255) not null comment '文件路径',
  type        int          not null comment '1：封面、2：文章内容图片、3：其他',
  article_id  int          null comment '文章编号',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '修改日期',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者',
  constraint sys_file_article_fk
    foreign key (article_id) references sys_article (id)
)
  comment '文件';

create table sys_label
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) not null comment '标签名',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建时间',
  modify_time date         null comment '修改时间',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者'
)
  comment '标签';

create table sys_article_label
(
  id          int auto_increment comment '编号'
    primary key,
  article_id  int          not null comment '文章编号',
  label_id    int          not null comment '标签编号',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建时间',
  modify_time date         null comment '修改时间',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者',
  constraint sys_article_fk
    foreign key (article_id) references sys_article (id),
  constraint sys_label_fk
    foreign key (label_id) references sys_label (id)
)
  comment '文章标签关联';

create table sys_log
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255)  null comment '名称',
  browser     varchar(255)  null comment '浏览器',
  operation   varchar(20)   null comment '操作方式：GET/POST',
  from_url    varchar(1000) null comment '访问的实际url地址',
  ip          varchar(200)  null comment '来源ip地址',
  url         varchar(255)  null comment '访问url相对地址',
  sort        int           null comment '排序',
  status      int           null comment '状态',
  remark      varchar(255)  null comment '备注',
  is_enable   tinyint       null comment '是否可用，1：可用，0：不可用',
  create_time date          null comment '创建日期',
  modify_time date          null comment '末次更新时间',
  create_user varchar(255)  null comment '创建用户名称',
  modify_user varchar(255)  null comment '末次更新用户名称'
)
  comment '日志' charset = utf8;

create table sys_page
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) not null comment '页面名称',
  url         varchar(255) not null comment '页面路径',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '修改日期',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者'
)
  comment '页面';

create table sys_res
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(11)   null comment '名称',
  parent_id   int           null comment '父权限资源编号',
  des         varchar(1024) null comment '描述',
  url         varchar(512)  null comment 'url地址',
  level       int           null comment '层级',
  icon_cls    varchar(255)  null comment '图标',
  type        varchar(255)  null comment '类型：1 功能 2 权限',
  sort        int           null comment '排序',
  status      int           null comment '状态',
  remark      varchar(255)  null comment '备注',
  is_enable   tinyint       null comment '是否可用，1：可用，0：不可用',
  create_time date          null comment '创建日期',
  modify_time date          null comment '末次更新时间',
  create_user varchar(255)  null comment '创建用户名称',
  modify_user varchar(255)  null comment '末次更新用户名称',
  constraint sys_res_parent_fk
    foreign key (parent_id) references sys_res (id)
)
  comment '权限资源' charset = utf8;

create table sys_role
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) null comment '名称',
  parent_id   int          null comment '父角色编号',
  des         varchar(128) null comment '描述',
  icon_cls    varchar(55)  null comment '图标',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否可用，1：可用，0：不可用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '末次更新时间',
  create_user varchar(255) null comment '创建用户名称',
  modify_user varchar(255) null comment '末次更新用户名称',
  constraint sys_role_parent_fk
    foreign key (parent_id) references sys_role (id)
)
  comment '权限' charset = utf8;

create table sys_role_res
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) null comment '名称',
  role_id     int          not null comment '角色编号',
  res_id      int          not null comment '权限资源编号',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否可用，1：可用，0：不可用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '末次更新时间',
  create_user varchar(255) null comment '创建用户名称',
  modify_user varchar(255) null comment '末次更新用户名称',
  constraint sys_res_fk
    foreign key (res_id) references sys_res (id),
  constraint sys_role_fk
    foreign key (role_id) references sys_role (id)
)
  comment '角色权限关联' charset = utf8;

create table sys_setting
(
  id              int auto_increment comment '编号'
    primary key,
  name            varchar(255) null comment '名称',
  web_url         varchar(255) null comment '站点地址',
  web_title       varchar(255) null comment '站点标题',
  web_child_title varchar(255) null comment '站点子标题',
  web_message     varchar(255) null comment '站点基础信息',
  web_key         varchar(255) null comment '站点关键词',
  sort            int          null comment '排序',
  status          int          null comment '状态',
  remark          varchar(255) null comment '备注',
  is_enable       tinyint      null comment '是否启用',
  create_time     date         null comment '创建日期',
  modify_time     date         null comment '修改日期',
  create_user     varchar(255) null comment '创建者',
  modify_user     varchar(255) null comment '修改者'
)
  comment '系统基本设置';

create table sys_user
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(255) not null comment '用户名',
  password    varchar(255) not null comment '密码',
  email       varchar(255) null comment '邮箱',
  qq          int          null comment 'qq号',
  github      varchar(255) null comment 'github账号',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否启用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '修改日期',
  create_user varchar(255) null comment '创建者',
  modify_user varchar(255) null comment '修改者'
)
  comment '用户';

create table sys_user_role
(
  id          int auto_increment comment '编号'
    primary key,
  name        varchar(254) null comment '名称',
  user_id     int          not null comment '用户编号',
  role_id     int          not null comment '角色编号',
  sort        int          null comment '排序',
  status      int          null comment '状态',
  remark      varchar(255) null comment '备注',
  is_enable   tinyint      null comment '是否可用，1：可用，0：不可用',
  create_time date         null comment '创建日期',
  modify_time date         null comment '末次更新时间',
  create_user varchar(255) null comment '创建用户名称',
  modify_user varchar(255) null comment '末次更新用户名称',
  constraint sys_role1_fk
    foreign key (role_id) references sys_role (id),
  constraint sys_user_fk
    foreign key (user_id) references sys_user (id)
)
  comment '用户角色关联' charset = utf8;