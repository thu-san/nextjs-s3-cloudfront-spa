import BlogLayout from './_components/BlogLayout';
import BlogPostCard from './_components/BlogPostCard';
import BlogNavigation from './_components/BlogNavigation';
import { getBlogPostsByCategory } from '@/data/blog-posts';

export default function BlogPage() {
  const posts = getBlogPostsByCategory();
  
  return (
    <BlogLayout>
      <h1>Blog</h1>
      <BlogNavigation />
      <div>
        {posts.map((post) => (
          <BlogPostCard key={post.id} post={post} />
        ))}
      </div>
    </BlogLayout>
  );
}