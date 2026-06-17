-- migrate:up

CREATE SCHEMA IF NOT EXISTS moviefinder_app_go;

-- Move legacy objects from public into moviefinder_app_go (embedded-Postgres history).
DO $$
DECLARE
  obj text;
BEGIN
  FOREACH obj IN ARRAY ARRAY[
    'user_sessions', 'user_accounts', 'feed', 'feed_session_mapping', 'entities',
    'external_data', 'media', 'media_images', 'genres', 'media_genres',
    'people', 'media_relationships', 'credits', 'videos', 'schema_migrations'
  ]
  LOOP
    IF EXISTS (
      SELECT 1 FROM information_schema.tables
      WHERE table_schema = 'public' AND table_name = obj
    ) THEN
      EXECUTE format('ALTER TABLE public.%I SET SCHEMA moviefinder_app_go', obj);
    END IF;
  END LOOP;
END $$;

DO $$
DECLARE
  mv text;
BEGIN
  FOREACH mv IN ARRAY ARRAY['media_mv', 'media_images_mv', 'genres_mv', 'media_genres_mv']
  LOOP
    IF EXISTS (
      SELECT 1 FROM pg_matviews WHERE schemaname = 'public' AND matviewname = mv
    ) THEN
      EXECUTE format('ALTER MATERIALIZED VIEW public.%I SET SCHEMA moviefinder_app_go', mv);
    END IF;
  END LOOP;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.views
    WHERE table_schema = 'public' AND table_name = 'media_denormalized_v'
  ) THEN
    ALTER VIEW public.media_denormalized_v SET SCHEMA moviefinder_app_go;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'public' AND p.proname = 'refresh_media_mv'
  ) THEN
    ALTER FUNCTION public.refresh_media_mv() SET SCHEMA moviefinder_app_go;
  END IF;
END $$;

-- migrate:down

-- Objects remain in moviefinder_app_go; down is intentionally a no-op.
