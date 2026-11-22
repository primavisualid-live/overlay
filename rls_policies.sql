-- RLS Policies for Tournament Overlay System
-- Run this in Supabase SQL Editor

-- Enable RLS on all tables
ALTER TABLE tournament_state ENABLE ROW LEVEL SECURITY;
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_history ENABLE ROW LEVEL SECURITY;

-- ============================================
-- tournament_state: Single row (id=1) for live state
-- anon: SELECT + UPDATE (only id=1)
-- ============================================
DROP POLICY IF EXISTS "anon_select_tournament_state" ON tournament_state;
CREATE POLICY "anon_select_tournament_state"
ON tournament_state FOR SELECT
TO anon
USING (true);

DROP POLICY IF EXISTS "anon_update_tournament_state" ON tournament_state;
CREATE POLICY "anon_update_tournament_state"
ON tournament_state FOR UPDATE
TO anon
USING (id = 1)
WITH CHECK (id = 1);

-- ============================================
-- teams: Team registry per sport
-- anon: SELECT + INSERT + UPDATE + DELETE (full CRUD from control panel)
-- ============================================
DROP POLICY IF EXISTS "anon_select_teams" ON teams;
CREATE POLICY "anon_select_teams"
ON teams FOR SELECT
TO anon
USING (true);

DROP POLICY IF EXISTS "anon_insert_teams" ON teams;
CREATE POLICY "anon_insert_teams"
ON teams FOR INSERT
TO anon
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_teams" ON teams;
CREATE POLICY "anon_update_teams"
ON teams FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_teams" ON teams;
CREATE POLICY "anon_delete_teams"
ON teams FOR DELETE
TO anon
USING (true);

-- ============================================
-- matches: Match schedule per sport
-- anon: SELECT + INSERT + UPDATE + DELETE (full CRUD from control panel)
-- ============================================
DROP POLICY IF EXISTS "anon_select_matches" ON matches;
CREATE POLICY "anon_select_matches"
ON matches FOR SELECT
TO anon
USING (true);

DROP POLICY IF EXISTS "anon_insert_matches" ON matches;
CREATE POLICY "anon_insert_matches"
ON matches FOR INSERT
TO anon
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_update_matches" ON matches;
CREATE POLICY "anon_update_matches"
ON matches FOR UPDATE
TO anon
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "anon_delete_matches" ON matches;
CREATE POLICY "anon_delete_matches"
ON matches FOR DELETE
TO anon
USING (true);

-- ============================================
-- match_history: Archived match results
-- anon: SELECT + INSERT (view history + archive from control panel)
-- ============================================
DROP POLICY IF EXISTS "anon_select_match_history" ON match_history;
CREATE POLICY "anon_select_match_history"
ON match_history FOR SELECT
TO anon
USING (true);

DROP POLICY IF EXISTS "anon_insert_match_history" ON match_history;
CREATE POLICY "anon_insert_match_history"
ON match_history FOR INSERT
TO anon
WITH CHECK (true);

-- ============================================
-- Verify policies
-- ============================================
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE schemaname = 'public'
AND tablename IN ('tournament_state', 'teams', 'matches', 'match_history')
ORDER BY tablename, policyname;