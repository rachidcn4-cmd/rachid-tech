import {createClient} from '@supabase/supabase-js'
export const supabase = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!)
export const supabaseAdmin = () => createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!)
export async function isAdmin(userId:string){ const {data}=await supabase.from('admins').select('user_id').eq('user_id',userId).maybeSingle(); return !!data }
