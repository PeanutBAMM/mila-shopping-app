-- Create storage buckets
INSERT INTO storage.buckets (id, name, public) VALUES 
  ('receipts', 'receipts', false),
  ('recipes', 'recipes', true),
  ('avatars', 'avatars', true),
  ('products', 'products', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies for receipts bucket
CREATE POLICY "Users can upload own receipts" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'receipts' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can view own receipts" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'receipts' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete own receipts" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'receipts' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- Storage policies for recipes bucket
CREATE POLICY "Users can upload recipe images" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'recipes' AND 
    auth.uid() IS NOT NULL
  );

CREATE POLICY "Anyone can view recipe images" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'recipes'
  );

CREATE POLICY "Users can delete own recipe images" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'recipes' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- Storage policies for avatars bucket
CREATE POLICY "Users can upload own avatar" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'avatars' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Anyone can view avatars" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'avatars'
  );

CREATE POLICY "Users can update own avatar" ON storage.objects
  FOR UPDATE USING (
    bucket_id = 'avatars' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete own avatar" ON storage.objects
  FOR DELETE USING (
    bucket_id = 'avatars' AND 
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- Storage policies for products bucket
CREATE POLICY "Authenticated users can upload product images" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'products' AND 
    auth.uid() IS NOT NULL
  );

CREATE POLICY "Anyone can view product images" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'products'
  );