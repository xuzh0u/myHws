CREATE DATABASE db_photographers;

CREATE TABLE Users (
    u_user_id serial NOT NULL,
    u_user_name varchar(255) NOT NULL,
    u_user_email varchar(255) NOT NULL,
    u_user_hashed_password varchar(255) NOT NULL,
    -- 以上是最基础的信息
    -- 如果需要其他的内容建议在开发后期再考虑添加

    PRIMARY KEY (u_user_id)
);

CREATE TABLE Photos (
    p_photo_id serial NOT NULL,
    p_photo_name varchar(255) NOT NULL,
    p_photo_description text,
    -- TODO: 这里应设置的参数我不知道有哪些 请大家帮忙添一下

    PRIMARY KEY (p_photo_id)
);

CREATE TABLE Comments (
    c_comment_id serial NOT NULL,
    c_photo_id serial NOT NULL,
    c_comment_content text NOT NULL, -- 一直考虑纯文本
    c_comment_replied_id serial, -- 可以空, 因为不一定是在回复他人评论

    PRIMARY KEY (c_comment_id),
    FOREIGN KEY (c_photo_id) REFERENCES Photos (p_photo_id)
);

CREATE TABLE Questions (
    q_question_id serial NOT NULL,
    q_question_content text NOT NULL,  -- [暂时]考虑纯文本 [图片将来以粘贴上传-转为路径的方式渲染, 具体看外部有无合适插件?这里还没调研过]

    PRIMARY KEY (q_question_id)
);

CREATE TABLE Answers (
    a_answer_id serial NOT NULL,
    a_question_id serial NOT NULL,
    a_answer_content text NOT NULL,  -- [暂时]考虑纯文本 图片插入的考虑同上
    a_adopted boolean NOT NULL default 0, -- 默认未采纳

    PRIMARY KEY (a_answer_id),
    FOREIGN KEY (a_question_id) REFERENCES Questions(q_question_id)
);

CREATE TABLE Replies_under_answers ( -- 针对Answer的回复  一直考虑纯文本
    r_reply_id serial NOT NULL,
    r_reply_to_answer_id serial NOT NULL,
    r_reply_content text NOT NULL,

    PRIMARY KEY (r_reply_id),
    FOREIGN KEY (r_reply_to_answer_id) REFERENCES Answers (a_answer_id)
);

CREATE TABLE Tags (
    t_tag_name varchar(255) NOT NULL,

    PRIMARY KEY (t_tag_name)
);

CREATE TABLE Relations_Photo_Tag (
    l_relation_id serial NOT NULL,
    l_relation_photo_id serial NOT NULL,
    l_relation_tag_name varchar(255) NOT NULL,

    PRIMARY KEY (l_relation_id),
    FOREIGN KEY (l_relation_photo_id) REFERENCES Photos (p_photo_id),
    FOREIGN KEY (l_relation_tag_name) REFERENCES Tags (t_tag_name)
);

CREATE TABLE Likes (
    i_like_id serial NOT NULL,
    i_be_liked_photo serial NOT NULL,
    i_like_giver serial NOT NULL,

    PRIMARY KEY (i_like_id),
    FOREIGN KEY (i_be_liked_photo) REFERENCES Users (u_user_id),
    FOREIGN KEY (i_like_giver) REFERENCES Users (u_user_id),
    UNIQUE (i_be_liked_photo, i_like_giver)
);
