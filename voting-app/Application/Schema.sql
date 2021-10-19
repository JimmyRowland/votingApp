-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE polls (
    poll_id UUID DEFAULT uuid_generate_v4() NOT NULL,
    poll_name TEXT NOT NULL,
    PRIMARY KEY(id, poll_id)
);
CREATE TABLE options (
    option_id UUID DEFAULT uuid_generate_v4() NOT NULL,
    poll_id UUID NOT NULL,
    option_label TEXT NOT NULL,
    PRIMARY KEY(id, option_id)
);
CREATE INDEX options_poll_id_index ON options (poll_id);
CREATE TABLE votes (
    vote_id UUID DEFAULT uuid_generate_v4() NOT NULL,
    poll_id UUID NOT NULL,
    option_id UUID NOT NULL,
    PRIMARY KEY(id, vote_id)
);
CREATE INDEX votes_poll_id_index ON votes (poll_id);
CREATE INDEX votes_option_id_index ON votes (option_id);
ALTER TABLE options ADD CONSTRAINT options_ref_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE NO ACTION;
ALTER TABLE votes ADD CONSTRAINT votes_ref_option_id FOREIGN KEY (option_id) REFERENCES options (id) ON DELETE NO ACTION;
ALTER TABLE votes ADD CONSTRAINT votes_ref_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id) ON DELETE NO ACTION;
ALTER TABLE votes ADD CONSTRAINT option_id_poll_id_unique UNIQUE (option_id, poll_id);