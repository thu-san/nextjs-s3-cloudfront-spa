import BlogLayout from '../_components/BlogLayout';
import BlogPostCard from '../_components/BlogPostCard';
import NestedBlogNavigation from '../_components/NestedBlogNavigation';
import { getBlogPostsByCategory } from '@/data/blog-posts';

export default function NestedBlogPage() {
  const posts = getBlogPostsByCategory('nested');

  return (
    <BlogLayout>
      <NestedBlogNavigation />
      <hr />
      <h1>Nested Blog</h1>
      <div>
        {posts.map((post) => (
          <BlogPostCard key={post.id} post={post} basePath="/blog/nested" />
        ))}
      </div>
    </BlogLayout>
  );
}
